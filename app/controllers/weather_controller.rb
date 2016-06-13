require 'pry'
require 'twilio-ruby'
class WeatherController < ApplicationController
  include Webhookable

  skip_before_filter  :verify_authenticity_token

  def route_me
    @body_request = params[:Body].split(",")
    @requesting_number = params[:From]
    # "=>"+16784917762",]

    if @body_request.length == 2
      get_weather
    elsif @body_request.length ==1
      access_answer
    else 
      bad_request
    end
  
  end


  def get_weather
    response = Twilio::TwiML::Response.new do |r|
     
      # body_request = params[:Body].split(",")
      @city = @body_request[0].capitalize
      @state = @body_request[1].upcase

      weather_key = ENV["WEATHER_KEY"]

      @response = HTTParty.get("http://api.wunderground.com/api/#{weather_key}/conditions/q/#{@state}/#{@city}.json")

        binding.pry
      @temperature = (@response["current_observation"]["temp_f"]).round
      
      if @temperature.nil?
        bad_request
      end
      wd = WeatherData.new
      wd.update(:temperature => @temperature, :city=> @city, :state => @state)
      wd.save

      send_question
     
    end
    render_twiml response
  end

  def bad_request
      text_message = "The request must be in this format: 'City,State' with no spaces between the City, comma and State.  Please try again."
      phone_number = @requesting_number.slice(0..1)
      phone_number.each do |i|
        client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
        message = client.messages.create from: '(678) 247-2394', to: i, body: text_message  
      end
  end

  # def bad_answer


  def send_question
      text_message = "What is the current temperature in #{@city}, #{@state}?"
      phone_number = ['(678)491-7762','(404)641-7242']
      phone_number.each do |i|
        client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
        message = client.messages.create from: '(678) 247-2394', to: i, body: text_message  
      end
  end

  def access_answer
    temperature_guess = params[:Body].to_i
    actual_temperature = WeatherData.last.temperature
    city = WeatherData.last.city
    temperature_difference = (temperature_guess - actual_temperature).round
   
    response = Twilio::TwiML::Response.new do |r|
      if temperature_difference.between?(-1,1)
        r.message "You win! Your answer was exactly right or within one degree."
      elsif temperature_difference < -1
        r.message "You guessed too low by #{temperature_difference.abs} degrees. The temperature is actually #{actual_temperature} in #{city}"
      elsif temperature_difference > 1
        r.message "You guessed too high by #{temperature_difference.abs} degrees.  The temperature is actually #{actual_temperature} in #{city}"
      end
    end
    render_twiml response
  end


  # def route_me
  #   @body_request = params[:Body].split(",")

  #   if @body_request.length == 3 && @body_request[0] == "q" 
  #     get_weather
  #   else
  #     access_answer
  #   end
  # end


end

require 'twilio-ruby'
class WeatherController < ApplicationController
  include Webhookable

  def route_me
    @body_request = params[:Body].split(",")
    if @body_request.length == 3 && @body_request[0] == "q" 
      get_weather
    else
      access_answer
    end
  end

#   def get_weather
#     response = Twilio::TwiML::Response.new do |r|
#       # @state = params[:state]
#       # @city = params[:city]
#       body_request = params[:Body].split(",")
#       @city = @body_request[1]
#       @state = @body_request[0]
#       weather_key = ENV["WEATHER_KEY"]
#       @response = HTTParty.get("http://api.wunderground.com/api/#{weather_key}/conditions/q/#{@state}/#{@city}.json")
#       @temperature = @response["current_observation"]["temp_f"]
#       send_question
#       # r.Message "What is the current temperature in #{@city}, #{@state}"
#     end
#     # render_twiml response
#   end



#   def access_answer
#   end
  

# end 

  def get_weather
    response = Twilio::TwiML::Response.new do |r|
      # @state = params[:state]
      # @city = params[:city]
      wd = WeatherData.new
      body_request = params[:Body].split(",")
      @city = body_request[2]
      @state = body_request[1]
      weather_key = ENV["WEATHER_KEY"]
      @response = HTTParty.get("http://api.wunderground.com/api/#{weather_key}/conditions/q/#{@state}/#{@city}.json")
      @temperature = @response["current_observation"]["temp_f"]
      # wd=WeatherData.create(:temperature => @temperature, :city=> @city, :state => @state)
      wd.update(:temperature => @temperature, :city=> @city, :state => @state)
      wd.save
      send_question
      # r.Message "What is the current temperature in #{@city}, #{@state}"
    end
    render_twiml response
  end

  def send_question
    # phone_number = []
    # phone_number = params[:phone_number].split(",")

      text_message = "What is the current temperature in #{@city}, #{@state}?"
   

      phone_number = ['(678)491-7762']
      # , '(404)641-7242']
      phone_number.each do |i|

      client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
      message = client.messages.create from: '(678)212-5314', to: i, body: text_message  

  end

  def access_answer
    temperature_guess = params[:Body]
    temperature_difference = temperature_guess - WeatherData.last.temperature
    
    response = Twilio::TwiML::Response.new do |r|
      if temperature_difference == 0
        r.message "Your got it exactly right!!!"
      elsif temperature_difference < 0
        r.message "You guessed too low by #{temperature_difference.abs}."
      elsif temperature_difference > 0
        r.message "You guessed too high by #{temperature_difference}."
      end
    end
    render_twiml response
  end
 end
end

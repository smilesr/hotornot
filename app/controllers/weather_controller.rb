require 'twilio-ruby'
class WeatherController < ApplicationController
  include Webhookable

  # def route_me
  #   @body_request = params[:Body].split(",")
  #   if @body_request[0] == "@+"
  #     get_weather
  #     send_question
  #   else
  #     access_answer
  #   end
  # end

  def get_weather
    response = Twilio::TwiML::Response.new do |r|
      # @state = params[:state]
      # @city = params[:city]
      body_request = params[:Body].split(",")
      @city = @body_request[1]
      @state = @body_request[0]
      weather_key = ENV["WEATHER_KEY"]
      @response = HTTParty.get("http://api.wunderground.com/api/#{weather_key}/conditions/q/#{@state}/#{@city}.json")
      @temperature = @response["current_observation"]["temp_f"]
      send_question
      # r.Message "What is the current temperature in #{@city}, #{@state}"
    end
    # render_twiml response
  end

  def send_question
      response = Twilio::TwiML::Response.new do |r|
        r.Message "What is the current temperature in #{@city}, #{@state}"
      end
  end

  def access_answer
  end
  

end 

  # def get_weather
  #   response = Twilio::TwiML::Response.new do |r|
  #     # @state = params[:state]
  #     # @city = params[:city]
  #     body_request = params[:Body].split(",")
  #     @city = body_request[2]
  #     @state = body_request[1]
  #     weather_key = ENV["WEATHER_KEY"]
  #     @response = HTTParty.get("http://api.wunderground.com/api/#{weather_key}/conditions/q/#{@state}/#{@city}.json")
  #     @temperature = @response["current_observation"]["temp_f"]
  #     r.Message "What is the current temperature in #{@city}, #{@state}"
  #   end
  #   render_twiml response
  # end

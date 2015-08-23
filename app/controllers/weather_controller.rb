require 'twilio-ruby'
class WeatherController < ApplicationController
  include Webhookable

  def get_weather
    response = Twilio::TwiML::Response.new do |r|
      # @state = params[:state]
      # @city = params[:city]
      body_request = params[:Body].split(",")
      @city = body_request[1]
      @state = body_request[0]
      weather_key = ENV["WEATHER_KEY"]
      @response = HTTParty.get("http://api.wunderground.com/api/#{weather_key}/conditions/q/#{@state}/#{@city}.json")
      @temperature = @response["current_observation"]["temp_f"]
      r.Message "What is the current temperature in #{@city}, #{@state}"
    end
    render_twiml response
  end
end 

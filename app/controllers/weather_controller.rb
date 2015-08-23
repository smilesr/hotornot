require 'twilio-ruby'
class WeatherController < ApplicationController
  include Webhookable

  def get_weather
    response = Twilio::TwiML::Response.new do |r|
      # @state = params[:state]
      # @city = params[:city]
      body_request = params[:Body].split(",")
      @city = body_request[1]
      @state = body_request[2]
      weather_key = ENV["WEATHER_KEY"]
      @response = HTTParty.get("http://api.wunderground.com/api/#{weather_key}/conditions/q/#{@state}/#{@city}.json")
      @temperature = @response["current_observation"]["temp_f"]
    end
    render_twiml response
  end
end 

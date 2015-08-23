class WeatherController < ApplicationController

  def get_weather
    @state = params[:state]
    @city = params[:city]
    weather_key = ENV["WEATHER_KEY"]
    @response = HTTParty.get("http://api.wunderground.com/api/#{weather_key}/conditions/q/#{@state}/#{@city}.json")
    @temperature = @response["current_observation"]["temp_f"]
    render
  end
end 

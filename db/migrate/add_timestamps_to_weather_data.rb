class AddTimestampsToWeatherData < ActiveRecord::Migration
    def change_table
      add_column(:weather_data, :created_at, :datetime)
      add_column(:weather_data, :updated_at, :datetime)
    end
end
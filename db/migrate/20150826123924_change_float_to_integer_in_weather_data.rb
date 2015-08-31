class ChangeFloatToIntegerInWeatherData < ActiveRecord::Migration
  def up
    change_column :weather_data, :temperature, :integer
  end

  def down
    change_column :weather_data, :temperature, :float
  end
end

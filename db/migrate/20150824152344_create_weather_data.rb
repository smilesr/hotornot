class CreateWeatherData < ActiveRecord::Migration
  def change
    create_table :weather_data do |t|
      t.float :temperature
      t.string :city
      t.string :state
    end
  end
end

# frozen_string_literal: true

module  Services
  class ScrapSite
    include Callable

    def initialize(url)
      @url = url
    end

    def call
      # clear_data_base
      windguru_data = HTTParty.get('https://www.windguru.net/int/iapi.php?q=forecast&id_model=52&rundef=2022021512x0x42x0x42&initstr=2022021512&id_spot=48299&WGCACHEABLE=21600&cachefix=52.451x4.564x0')
      windguru_data = HTTParty.get('https://www.windguru.net/int/iapi.php?q=forecast&id_model=52&rundef=2022021600x0x42x0x42&initstr=2022021600&id_spot=48299&WGCACHEABLE=21600&cachefix=52.451x4.564x0')
      forcast_data = windguru_data['fcst']
      wind_speed_objects = forcast_data['WINDSPD'].map.with_index do |wind_speed, i|
        wind_speed > 15 ? { wind_speed: wind_speed, hour: i } : nil
      end.compact
      initial_hour = forcast_data['init_h'].to_i
      create_wind_forecasts(wind_speed_objects,initial_hour)
    end

    private

    def clear_data_base
      WindForecast.destroy_all
    end

    def calculate_hour(initial_hour, hour)
      new_hour = initial_hour + hour

      new_hour -= 24 if new_hour > 24

      new_hour
    end

    def create_wind_forecasts(objects,initial_hour)
      objects.each do |wind_speed_object|
        WindForecast.create!(
          wind_speed: wind_speed_object[:wind_speed],
          hour: calculate_hour(initial_hour, wind_speed_object[:hour])
        )
      end
    end
  end
end

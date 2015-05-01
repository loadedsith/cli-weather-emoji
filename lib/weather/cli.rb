# encoding: UTF-8

module Weather
  class CLI
    BASE_MAPPINGS_NO_EMOJI = {
      chanceflurries: "~❅",
      chancerain: "~☔",
      chancesleet: "~❆",
      chancesnow: "~❆",
      chancetstorms: "~☈",
      clear: "☼",
      cloudy: "☁",
      flurries: "❆",
      fog: "♒",
      hazy: "♒",
      mostlycloudy: "☁",
      mostlysunny: "☀",
      partlycloudy: "-☁",
      partlysunny: "-☀",
      rain: "☔",
      sleet: "❆",
      snow: "❆",
      sunny: "☼",
      tstorms: "☈"
    }

    BASE_MAPPINGS_EMOJI = {
      chanceflurries: "❄️?",
      chancerain: "☔?",
      chancesleet: "❄️?",
      chancesnow: "❄️?",
      chancetstorms: "⚡️?",
      clear: "☀️",
      cloudy: "☁️",
      flurries: "❄️",
      fog: "🌁",
      hazy: "🌁",
      mostlycloudy: "☁️",
      mostlysunny: "☀️",
      partlycloudy: "⛅️",
      partlysunny: "⛅️",
      rain: "☔",
      sleet: "❄️",
      snow: "❄️",
      sunny: "☀️",
      tstorms: "⚡️"
    }


    BASE_MAPPINGS = BASE_MAPPINGS_EMOJI
    ICON_MAPPINGS = BASE_MAPPINGS.inject({}) do |memo, arr|
      memo[arr[0]] = arr[1]
      memo["nt_#{arr[0]}".to_sym] = arr[1]
      memo
    end

    def initialize(num_periods = 8)
      @config ||= Weather::Config.new
    end

    def current_conditions
      conditions_request = open(construct_conditions_url)
      json_response = JSON.load conditions_request
      json_response['current_observation']['feelslike_f']
    end

    def forecast_icons
      
      conditions_request = open(construct_forecast_url)
      json_response = JSON.load conditions_request
      high = json_response['forecast']['simpleforecast']['forecastday'][0]['high']['fahrenheit']
      low = json_response['forecast']['simpleforecast']['forecastday'][0]['low']['fahrenheit']
      conditon =  json_response['forecast']['simpleforecast']['forecastday'][0]['conditions']
      icon = json_response['forecast']['simpleforecast']['forecastday'][0]['icon']
      icon = ICON_MAPPINGS[icon.to_sym];

      result = "#{low}˚/#{high}˚"
      t = Time.now
      t.to_s 
      date = t.strftime "%l:%M%P"

      icons = [result]
      json_response['forecast']['txt_forecast']['forecastday'].collect do |forecast|
        icons << ICON_MAPPINGS[forecast['icon'].to_sym]
        if forecast['title'].match /night/i
          icons << ' '
        end
      end
      icons << "updated: " + date
      icons
    end

    private

    def construct_forecast_url
      "http://api.wunderground.com/api/#{@config.api_key}/forecast/q/#{@config.state}/#{@config.city}.json"
    end
    def construct_conditions_url
      "http://api.wunderground.com/api/#{@config.api_key}/conditions/q/#{@config.state}/#{@config.city}.json"
    end
  end
end

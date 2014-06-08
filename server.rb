require 'bundler'
Bundler.require(:default)

class Weather < Sinatra::Base
  register Sinatra::ConfigFile

  config_file "weather_config.yml"
  ForecastIO.api_key = settings.api_key

  configure do
    @@redis = Redis.new(host: "localhost", post: 6379)
  end

  get '/' do
    'Hello and welcome to cool weather server'
  end

#TODO throw some http basic auth here
  get '/weather' do
    forecast = @@redis.get(params[:cityState])

    if forecast
      forecast = JSON.parse(forecast)

    else
      puts 'grabbing from API ...'
      lat = params[:lat]
      lng = params[:lng]
      forecast = ForecastIO.forecast(lat , lng, {:params=>{:exclude=>"minutely,flags,alerts,daily"}})
      @@redis.setex(params[:cityState] , 3600, forecast.to_json)
    end

    content_type :json
    forecast.to_json
  end
end

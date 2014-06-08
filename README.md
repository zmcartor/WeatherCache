WeatherCache
============

Forecast.io API gateway with Redis cache

### Why?
Forecast.io gives 1000 requests per day. Using a caching server stretches this
limit further by caching the most recent forcast for a city within Redis
for an hour.

### Getting started

#### Configure Redis
Configure Sinatra to connect to your Redis instance within the ```configure`` block.
``` ruby
configure do
  @@redis = Redis.new(host: "localhost", post: 6379)
end
```

#### ForecastIO api key
Create the file weather_config.yml and place your api key within like:
```api_key: 1234567890APIKeyWhoa```

#### Call the API endpoint
Send requests to the weather server in the form:
```http://server.com/weather?cityState=BoulderCOUnitedStates&lat=40.015931&lng=-105.279306 ```

The variable ```cityState``` is used as the Redis cache key and can be whatever
name you'd like for this location. The lat/lng coords are fed to the Forecast.io
API.

### Contribute
Pull reqs, issues or suggestions welcome!

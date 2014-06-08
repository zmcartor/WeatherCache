require_relative "server"

# the specified app classes will be mounted at these points
# mountPoint is not used in route determination


map "/" do
  run Weather
end

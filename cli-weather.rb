# encoding: UTF-8
$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))

require 'json'
require 'open-uri'

require 'lib/weather/config'
require 'lib/weather/cli'


begin
  forecast = Weather::CLI.new

  puts "\n"+forecast.forecast_icons.join(' ')
rescue  => error
  puts error
end




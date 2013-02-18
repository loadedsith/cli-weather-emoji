# encoding: UTF-8

module Weather
  class Config
    attr_reader :city, :state, :api_key

    def initialize
      begin
        @config = File.read(File.expand_path('~/.cli-weather.rc'))
        parse
      rescue Exception => e
        puts help_message
      end
    end

    def parse
      @config.split(/\n/).each do |line|
        if ! line.match /^(\s?#|\s)/
          attribute, value = line.split /\s?=\s?/
          self.instance_variable_set("@#{attribute}", value)
        end
      end
    end

    private

    def help_message
<<-HELP
Your ~/.cli-weather.rc does not exist or isn't readable. Here's an example for
you to customize:

city = Lynn
state = MA
api_key = <your wunderground API key>

HELP
    end
  end
end

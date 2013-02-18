## CLI Weather

This uses the Wunderground API to export icons representing 4 days worth of
weather. It's built in ruby.

## Installation

```bash
$ git clone git://github.com/djcp/cli-weather.git
$ cd cli-weather
$ bundle
```

## Configuration

Create a ```.cli-weather.rc``` file in your $HOME directory. It should look something like:

```
city = Lynn
state = MA
api_key = <your wunderground API key>
```

## Usage

I use a cron job to dump the icons out to a file named
"~/.cli-weather-forecast" that I then use to customize my bash prompt. The
command below will update it every 15 minutes.

```bash
  */15 * * * * source /home/djcp/.rvm/scripts/rvm && ruby /home/djcp/code/cli-weather/cli-weather.rb > /home/djcp/.cli-weather-forecast
```

And then in .bashrc:

```bash
  WEATHER=(< ~/.cli-weather-forecast)
  PS1="your current prompt but now with the ${WEATHER}"
```

## Author

Dan Collis-Puro

## License

MIT

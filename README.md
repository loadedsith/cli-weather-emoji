## CLI Weather

This uses the Wunderground API to export icons representing 4 days worth of
weather. It's built in ruby. It looks something like:

![](https://raw.github.com/djcp/cli-weather/master/images/bash_preview.png)


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


##Legend
###Prefixes

   * Chance of:  ~
   * Partly: -

###Complete List

   * Chance of Flurries: ~❅
   * Chance of Rain: ~☔
   * Chance of Sleet: ~❆
   * Chance of Snow: ~❆
   * Chance of Thunder Storms: ~☈
   * Clear: ☼
   * Cloudy: ☁
   * Flurries: ❆
   * Fog*: ♒
   * Hazy*: ♒
   * Mostly Cloudy: ☁
   * Mostly Sunny: ☀
   * Partly Cloudy: -☁
   * Partly Sunny: -☀
   * Rain*: ☔
   * Sleet: ❆
   * Snow: ❆
   * Sunny: ☼
   * Thunder Storms: ☈

*:[Monospace fonts with good support for these characters,](https://github.com/Lokaltog/powerline-fonts) will turn the rain, fog, and haze characters into a graphics in your terminal.

## Author

Dan Collis-Puro

## License

MIT

# Easy Statistic

[![Build Status](https://secure.travis-ci.org/bmsatierf/easy-statistic.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/bmsatierf/easy-statistic.png)][gemnasium]
[![Coverage Status](https://coveralls.io/repos/bmsatierf/easy-statistic/badge.png?branch=master)][coveralls]

[travis]: http://travis-ci.org/bmsatierf/easy-statistic
[gemnasium]: https://gemnasium.com/bmsatierf/easy-statistic
[coveralls]: https://coveralls.io/r/bmsatierf/easy-statistic

Basic statistic app built with Sinatra, jQuery (plus some ajax) and Bootstrap. At this moment the following operations/calculations are available:

* Discrete distribution: http://en.wikipedia.org/wiki/List_of_probability_distributions#Discrete_distributions
* Continuous distribution: http://en.wikipedia.org/wiki/List_of_probability_distributions#Continuous_distributions
* Measure of central tendency: http://en.wikipedia.org/wiki/Central_tendency
* Mode: http://en.wikipedia.org/wiki/Mode_(statistics)
* Median: http://en.wikipedia.org/wiki/Median_(statistics)
* Mean: http://en.wikipedia.org/wiki/Mean_(statistics)
* Statistical dispersion: http://en.wikipedia.org/wiki/Statistical_dispersion
* Variance: http://en.wikipedia.org/wiki/Variance
* Standard deviation: http://en.wikipedia.org/wiki/Standard_deviation
* Coefficient of variation: http://en.wikipedia.org/wiki/Coefficient_of_variation
* Normal distribution: http://en.wikipedia.org/wiki/Normal_distribution
* Basic charts, powered by Highcharts: http://www.highcharts.com

More content is coming soon.

## Development

Be sure Bundler is installed. After cloning the repo:

```console
$ bundle install
$ bundle exec rackup
```

## Testing

Most of the tests are based on class exercises.

```console
$ bundle exec ruby easy_test.rb
```

## To-dos

It would also be nice to achieve at least some responsiveness on Charts session. At this moment the charts looks nice 'on my computer' =)

I'm also thinking about using D3 (http://d3js.org) to plot some interesting Gaussian functions on normal distribution session, allowing better data visualization. Help here would be much appreciated.

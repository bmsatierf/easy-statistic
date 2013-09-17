#encoding: utf-8

ENV['RACK_ENV'] = 'test'

require File.expand_path('easy.rb')
require 'test/unit'
require 'rack/test'

class EasyTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_get_index
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('Estatística')
  end

  def test_get_about
    get '/about'
    assert last_response.ok?
    assert last_response.body.include?('Estatística')
  end

  def test_setup_sorted_array
    stat = Statistic.new("3,1,5,6,2,4")
    assert_equal([1,2,3,4,5,6], stat.ranked_data)
  end

  def test_setup_uniq_count
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    assert_equal({5=>1, 1=>2, 2=>1, 3=>3, 4=>2}, stat.uniq_count)
  end

  def test_invalid_distribution_type
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("other", "population")
    assert_equal("Invalid distribution type.", stat.table)
  end

  # DISCRETE TESTS
  def test_process_discrete_variable
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("discrete", "population")
    assert_equal(
      {
        0 => {"xi"=>1, "fi"=>2, "fr%"=>22, "F"=>2, "F%"=>22,  "xi*fi"=>2, "variance"=>"7.144"},
        1 => {"xi"=>2, "fi"=>1, "fr%"=>11, "F"=>3, "F%"=>33,  "xi*fi"=>2, "variance"=>"0.792"},
        2 => {"xi"=>3, "fi"=>3, "fr%"=>33, "F"=>6, "F%"=>66,  "xi*fi"=>9, "variance"=>"0.036"},
        3 => {"xi"=>4, "fi"=>2, "fr%"=>22, "F"=>8, "F%"=>88,  "xi*fi"=>8, "variance"=>"2.464"},
        4 => {"xi"=>5, "fi"=>1, "fr%"=>11, "F"=>9, "F%"=>100, "xi*fi"=>5, "variance"=>"4.452"}
      },
      stat.table
    )
  end

  def test_post_discrete_variable
    post '/?raw[data]=1,1,2,3,3,3,4,4,5&distribution_type=discrete'
    assert last_response.ok?
    assert last_response.body.include?('Processamento da variável quantitativa discreta')
  end

  def test_post_discrete_variable_without_data
    post '/?raw[data]=&distribution_type=discrete'
    assert last_response.ok?
    assert last_response.body.include?('É necessário informar os dados a serem processados, separados por vírgula.')
  end

  def test_discrete_mode
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("discrete", "population")
    assert_equal("3", stat.mode)
  end

  def test_discrete_median
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("discrete", "population")
    assert_equal(3, stat.median)
  end

  def test_discrete_mean
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("discrete", "population")
    assert_equal(2.89, stat.mean)
  end

  def test_discrete_chart_series
    stat = Statistic.new("1,2,2,3,5,5")
    stat.process_data("discrete", "population")
    assert_equal("{ data: [1,1,1,1], index: 3 },{ data: [null,2,2,2], index: 2 },{ data: [null,null,1,1], index: 1 },{ data: [null,null,null,2], index: 0 }", stat.chart["data"])
  end

  def test_discrite_chart_x_axis
    stat = Statistic.new("1,2,2,3,5,5")
    stat.process_data("discrete", "population")
    assert_equal(["1", "1,2", "1,2,3", "1,2,3,5"], stat.chart["xAxis"])
  end

  def test_discrete_population_variance
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("discrete", "population")
    assert_equal("1.654", stat.variance)
  end

  def test_discrete_sample_variance
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("discrete", "sample")
    assert_equal("1.861", stat.variance)
  end

  def test_discrete_sample_standard_deviation
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("discrete", "sample")
    assert_equal("1.364", stat.standard_deviation)
  end

  def test_discrete_population_standard_deviation
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("discrete", "population")
    assert_equal("1.286", stat.standard_deviation)
  end

  def test_discrete_sample_coefficient_of_variation
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("discrete", "sample")
    assert_equal("47.20", stat.coefficient_of_variation)
  end

  def test_discrete_population_coefficient_of_variation
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("discrete", "population")
    assert_equal("44.50", stat.coefficient_of_variation)
  end

  # CONTINUOUS TESTS
  def test_process_continuous_variable
    stat = Statistic.new("20,26,26,27,30,31,32,36,38,40")
    stat.process_data("continuous", "population")
    assert_equal(
    {
      1 => {"class"=>1, "at"=>[20, 27], "fi"=>3, "fr%"=>30, "F"=>"3 (1° a 3° posição)",   "F%"=>30,  "xi"=>23.5, "xi*fi"=>70.5,  "variance"=>"147.000"},
      2 => {"class"=>2, "at"=>[27, 34], "fi"=>4, "fr%"=>40, "F"=>"7 (4° a 7° posição)",   "F%"=>70,  "xi"=>30.5, "xi*fi"=>122.0, "variance"=>"0.000"},
      3 => {"class"=>3, "at"=>[34, 41], "fi"=>3, "fr%"=>30, "F"=>"10 (8° a 10° posição)", "F%"=>100, "xi"=>37.5, "xi*fi"=>112.5, "variance"=>"147.000"}
    },
    stat.table)
  end

  def test_post_continuous_variable
    post '/?raw[data]=20,26,26,27,30,31,32,36,38,40&distribution_type=continuous'
    assert last_response.ok?
    assert last_response.body.include?('Processamento da variável quantitativa contínua')
  end

  def test_post_continuous_variable_without_data
    post '/?raw[data]=&distribution_type=continuous'
    assert last_response.ok?
    assert last_response.body.include?('É necessário informar os dados a serem processados, separados por vírgula.')
  end

  def test_continuous_mode_unimodal
    stat = Statistic.new("1000,1800,2000,2000,2000,2800,3000,3000,3100,4000")
    stat.process_data("continuous", "population")
    assert_equal("1500.5", stat.mode)
  end

  def test_continuous_mode_bimodal
    stat = Statistic.new("1000,1800,2000,2000,2000,2800,3000,3000,3000,4000")
    stat.process_data("continuous", "population")
    assert_equal("1500.5 e 2501.5", stat.mode)
  end

  def test_continuous_mode_multimodal
    stat = Statistic.new("1000,1000,1000,2500,3000,3000,3000,4000,4000,4000")
    stat.process_data("continuous", "population")
    assert_equal("1500.5, 2501.5 e 3502.5", stat.mode)
  end

  def test_continuous_mode_amodal
    stat = Statistic.new("1000,1500,1800,2000,2500,2800,3000,3500,3800,4000")
    stat.process_data("continuous", "population")
    assert_equal("N/A", stat.mode)
  end

  def test_discrete_median
    stat = Statistic.new("1000,1800,2000,2000,2000,2800,3000,3000,3100,4000")
    stat.process_data("continuous", "population")
    assert_equal("2001.000", stat.median)
  end

  def test_continuous_mean
    stat = Statistic.new("1000,1800,2000,2000,2000,2800,3000,3000,3100,4000")
    stat.process_data("continuous", "population")
    assert_equal(2201.2, stat.mean)
  end

  def test_continuous_chart_series
    stat = Statistic.new("1,2,2,3,5,5")
    stat.process_data("continuous", "population")
    assert_equal("{ data: [4,4], index: 1 },{ data: [null,2], index: 0 }", stat.chart["data"])
  end

  def test_continuous_chart_x_axis
    stat = Statistic.new("1,2,2,3,5,5")
    stat.process_data("continuous", "population")
    assert_equal(["2.5", "2.5,5.5"], stat.chart["xAxis"])
  end

  def test_continuous_population_variance
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("continuous", "population")
    assert_equal("1.580", stat.variance)
  end

  def test_continuous_sample_variance
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("continuous", "sample")
    assert_equal("1.778", stat.variance)
  end

  def test_continuous_sample_standard_deviation
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("continuous", "sample")
    assert_equal("1.333", stat.standard_deviation)
  end

  def test_continuous_population_standard_deviation
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("continuous", "population")
    assert_equal("1.257", stat.standard_deviation)
  end

  def test_continuous_sample_coefficient_of_variation
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("continuous", "sample")
    assert_equal("37.44", stat.coefficient_of_variation)
  end

  def test_continuous_population_coefficient_of_variation
    stat = Statistic.new("1,1,2,3,3,3,4,4,5")
    stat.process_data("continuous", "population")
    assert_equal("35.31", stat.coefficient_of_variation)
  end
end
#encoding: utf-8

class Statistic
  STANDARD_TABLE =
  {
    # Z       0.00    0.01    0.02    0.03    0.04    0.05    0.06    0.07    0.08    0.09
    0.0 => [0.0000, 0.0040, 0.0080, 0.0120, 0.0160, 0.0199, 0.0239, 0.0279, 0.0319, 0.0359],
    0.1 => [0.0398, 0.0438, 0.0478, 0.0517, 0.0557, 0.0596, 0.0636, 0.0675, 0.0714, 0.0753],
    0.2 => [0.0793, 0.0832, 0.0871, 0.0910, 0.0948, 0.0987, 0.1026, 0.1064, 0.1103, 0.1141],
    0.3 => [0.1179, 0.1217, 0.1255, 0.1293, 0.1331, 0.1368, 0.1406, 0.1443, 0.1480, 0.1517],
    0.4 => [0.1554, 0.1591, 0.1628, 0.1664, 0.1700, 0.1736, 0.1772, 0.1808, 0.1844, 0.1879],
    0.5 => [0.1915, 0.1950, 0.1985, 0.2019, 0.2054, 0.2088, 0.2123, 0.2157, 0.2190, 0.2224],
    0.6 => [0.2257, 0.2291, 0.2324, 0.2357, 0.2389, 0.2422, 0.2454, 0.2486, 0.2517, 0.2549],
    0.7 => [0.2580, 0.2611, 0.2642, 0.2673, 0.2704, 0.2734, 0.2764, 0.2794, 0.2823, 0.2852],
    0.8 => [0.2881, 0.2910, 0.2939, 0.2967, 0.2995, 0.3023, 0.3051, 0.3078, 0.3106, 0.3133],
    0.9 => [0.3159, 0.3186, 0.3212, 0.3238, 0.3264, 0.3289, 0.3315, 0.3340, 0.3365, 0.3389],
    1.0 => [0.3413, 0.3438, 0.3461, 0.3485, 0.3508, 0.3531, 0.3554, 0.3577, 0.3599, 0.3621],
    1.1 => [0.3643, 0.3665, 0.3686, 0.3708, 0.3729, 0.3749, 0.3770, 0.3790, 0.3810, 0.3830],
    1.2 => [0.3849, 0.3869, 0.3888, 0.3907, 0.3925, 0.3944, 0.3962, 0.3980, 0.3997, 0.4015],
    1.3 => [0.4032, 0.4049, 0.4066, 0.4082, 0.4099, 0.4115, 0.4131, 0.4147, 0.4162, 0.4177],
    1.4 => [0.4192, 0.4207, 0.4222, 0.4236, 0.4251, 0.4265, 0.4279, 0.4292, 0.4306, 0.4319],
    1.5 => [0.4332, 0.4345, 0.4357, 0.4370, 0.4382, 0.4394, 0.4406, 0.4418, 0.4429, 0.4441],
    1.6 => [0.4452, 0.4463, 0.4474, 0.4484, 0.4495, 0.4505, 0.4515, 0.4525, 0.4535, 0.4545],
    1.7 => [0.4554, 0.4564, 0.4573, 0.4582, 0.4591, 0.4599, 0.4608, 0.4616, 0.4624, 0.4633],
    1.8 => [0.4641, 0.4649, 0.4656, 0.4664, 0.4671, 0.4678, 0.4686, 0.4693, 0.4699, 0.4706],
    1.9 => [0.4713, 0.4719, 0.4726, 0.4732, 0.4738, 0.4744, 0.4750, 0.4756, 0.4761, 0.4767],
    2.0 => [0.4772, 0.4778, 0.4783, 0.4788, 0.4793, 0.4798, 0.4803, 0.4808, 0.4812, 0.4817],
    2.1 => [0.4821, 0.4826, 0.4830, 0.4834, 0.4838, 0.4842, 0.4846, 0.4850, 0.4854, 0.4857],
    2.2 => [0.4861, 0.4864, 0.4868, 0.4871, 0.4875, 0.4878, 0.4881, 0.4884, 0.4887, 0.4890],
    2.3 => [0.4893, 0.4896, 0.4898, 0.4901, 0.4904, 0.4906, 0.4909, 0.4911, 0.4913, 0.4916],
    2.4 => [0.4918, 0.4920, 0.4922, 0.4925, 0.4927, 0.4929, 0.4931, 0.4932, 0.4934, 0.4936],
    2.5 => [0.4938, 0.4940, 0.4941, 0.4943, 0.4945, 0.4946, 0.4948, 0.4949, 0.4951, 0.4952],
    2.6 => [0.4953, 0.4955, 0.4956, 0.4957, 0.4959, 0.4960, 0.4961, 0.4962, 0.4963, 0.4964],
    2.7 => [0.4965, 0.4966, 0.4967, 0.4968, 0.4969, 0.4970, 0.4971, 0.4972, 0.4973, 0.4974],
    2.8 => [0.4974, 0.4975, 0.4976, 0.4977, 0.4977, 0.4978, 0.4979, 0.4979, 0.4980, 0.4981],
    2.9 => [0.4981, 0.4982, 0.4982, 0.4983, 0.4984, 0.4984, 0.4985, 0.4985, 0.4986, 0.4986],
    3.0 => [0.4987, 0.4987, 0.4987, 0.4988, 0.4988, 0.4989, 0.4989, 0.4989, 0.4990, 0.4990]
  }

  attr_reader :raw_data,                # Raw data (user's entry)
              :ranked_data,             # Sorted array of numbers (rol)
              :uniq_count,              # Hash with the sum of each element
              :table,                   # Hash with the complete statistical data
              :chart,                   # Hash with the data used to plot the chart
              :mode,                    # http://en.wikipedia.org/wiki/Mode_(statistics)
              :median,                  # http://en.wikipedia.org/wiki/Median_(statistics)
              :mean,                    # http://en.wikipedia.org/wiki/Mean_(statistics)
              :class_range,             # at = (Xmax - Xmin) + 1)
              :number_of_classes,       # k = Math.sqrt(@ranked_data.length)
              :class_interval,          # ic = @class_range / @number_of_classes
              :distribution_type,       # discrete or continuous
              :collection_type,         # population or sample
              :median_class,            # Position on table hash used to calculate the median (continuous)
              :variance,                # http://en.wikipedia.org/wiki/Variance
              :standard_deviation,      # http://en.wikipedia.org/wiki/Standard_deviation
              :coefficient_of_variation # http://en.wikipedia.org/wiki/Coefficient_of_variation

  def initialize(data=nil)
    @raw_data = data
  end

  def process_data(distribution_type, collection_type)
    setup_ranked_data(@raw_data)
    setup_uniq_count

    @collection_type = collection_type
    @distribution_type = distribution_type

    case distribution_type
      when "discrete"   then process_discrete_distribution
      when "continuous" then process_continuous_distribution
      else return @table = "Invalid distribution type."
    end

    calculate_measure_of_central_tendency
    calculate_measure_of_dispersion
    prepare_chart_data
  end

  def normal_distribution(type, median, standard_deviation, less, greater)
    # http://en.wikipedia.org/wiki/Normal_distribution

    return case type
      when "less-than"             then calculate_less_than(median, standard_deviation, less.to_f)
      when "greater-than"          then calculate_greater_than(median, standard_deviation, greater.to_f)
      when "between"               then calculate_between(median, standard_deviation, less.to_f, greater.to_f)
      when "less-and-greater-than" then calculate_less_and_greater_than(median, standard_deviation, less.to_f, greater.to_f)
    end
  end

  def self.version
    "0.0.3"
  end

  private

  def setup_ranked_data(raw_data)
    @ranked_data = raw_data.split(",").map { |s| s.to_i }
    @ranked_data.sort!
  end

  def setup_uniq_count
    @uniq_count = Hash.new
    @ranked_data.uniq.each { |element| @uniq_count[element] = @ranked_data.count(element) }
  end

  def process_discrete_distribution
    # http://en.wikipedia.org/wiki/List_of_probability_distributions#Discrete_distributions

    @table = Hash.new
    accumulated_frequency = 0

    @uniq_count.each_with_index do |element, i|
      @table[i] = Hash.new
      @table[i]["xi"] = element[0]
      @table[i]["fi"] = element[1]
      @table[i]["fr%"] = (element[1]*100) / @ranked_data.length

      accumulated_frequency += element[1]
      @table[i]["F"] = accumulated_frequency
      @table[i]["F%"] = (accumulated_frequency * 100) / @ranked_data.length
      @table[i]["xi*fi"] = element[0] * element[1]
    end
  end

  def process_continuous_distribution
    # http://en.wikipedia.org/wiki/List_of_probability_distributions#Continuous_distributions

    @class_range = (@ranked_data.last - @ranked_data.first) + 1
    @number_of_classes = Math.sqrt(@ranked_data.length).to_i

    find_ideal_class_interval

    @table = Hash.new
    accumulated_frequency = 0
    lower_interval = @ranked_data.first

    for i in 1..@number_of_classes
      frequence = count_between(lower_interval, lower_interval + class_interval)
      next if frequence == 0

      @table[i] = Hash.new
      @table[i]["class"] = i
      @table[i]["at"] = [lower_interval, lower_interval + class_interval]

      @table[i]["fi"] = frequence
      @table[i]["fr%"] = (frequence * 100) / @ranked_data.length

      accumulated_frequency += frequence
      @table[i]["F"] = "#{accumulated_frequency} #{frequence_position(i, accumulated_frequency, frequence)}"
      @table[i]["F%"] = (accumulated_frequency * 100) / @ranked_data.length

      xi = (lower_interval + (lower_interval + class_interval).to_f) / 2.0
      @table[i]["xi"] = xi
      @table[i]["xi*fi"] = xi * frequence.to_f

      lower_interval += class_interval
    end
  end

  def count_between(lower, upper)
    @ranked_data.count { |v| v.between?(lower, (upper - 1)) }
  end

  def frequence_position(index, accumulated_frequency, frequence)
    # 0 elements
    return "" if frequence == 0

    # 1 element
    @median_class = index if (@ranked_data.length / 2) == frequence
    return "(#{accumulated_frequency}° posição)" if frequence == 1

    # n elements
    mid = (@ranked_data.length / 2)
    @median_class = index if mid >= (accumulated_frequency - frequence + 1) && mid <= accumulated_frequency
    "(#{accumulated_frequency - frequence + 1}° a #{accumulated_frequency}° posição)"
  end

  def find_ideal_class_interval
    attempts = -1
    begin
      if attempts == 2
        @class_range += 1
        attempts = 0
      else
        attempts += 1
      end

      case attempts
        when 0 then @class_interval = @class_range / @number_of_classes
        when 1 then @class_interval = @class_range / (@number_of_classes - 1)
        when 2 then @class_interval = @class_range / (@number_of_classes + 1)
      end
    end while @class_range % @number_of_classes > 0
  end

  def calculate_measure_of_central_tendency
    # http://en.wikipedia.org/wiki/Central_tendency

    calculate_mode
    calculate_median
    calculate_mean
  end

  def calculate_mode
    max = @uniq_count.values.max
    elements = @uniq_count.select { |k, v| v == max}

    return @mode = "N/A" if max == 1

    if @distribution_type == "discrete"
      calculate_discrete_mode(elements)
    else
      calculate_continuous_mode(elements)
    end
  end

  def calculate_discrete_mode(elements)
    arr_mode = elements.map { |element| element[0] }
    @mode = arr_mode.uniq.to_sentence
  end

  def calculate_continuous_mode(elements)
    arr_mode = Array.new

    elements.each do |element|
      @table.each do |row|
        lower_range, upper_range = row[1]["at"][0], row[1]["at"][1]
        arr_mode << (lower_range + upper_range).to_f / 2.to_f if element[0].between?(lower_range, upper_range - 1)
      end
    end

    @mode = arr_mode.uniq.to_sentence
  end

  def calculate_mean
    mean_sum = @table.map { |h| h[1]["xi*fi"] }.reduce(:+)
    @mean = (mean_sum.to_f / @ranked_data.length.to_f).round(2)
  end

  def calculate_median
    if @distribution_type == "discrete"
      calculate_discrete_median
    else
      calculate_continuous_median
    end
  end

  def calculate_discrete_median
    mid = @ranked_data.length / 2
    @median = if @ranked_data.length % 2 == 0
      '%.3f' % ((@ranked_data[mid].to_f + @ranked_data[mid - 1].to_f) / 2.to_f)
    else
      @ranked_data[mid + 1]
    end
  end

  def calculate_continuous_median
    mid = @ranked_data.length / 2
    lower_range = @table[@median_class]["at"][0]
    previous_f = @median_class == 1 ? 0 : @table[@median_class - 1]["F"].split(" ")[0].to_i

    @median = '%.3f' % (lower_range + (((mid - previous_f).to_f / @table[@median_class]["fi"].to_f) * @class_interval))
  end

  def prepare_chart_data
    prepare_chart_series
    prepare_chart_x_axis
  end

  def prepare_chart_series
    serie = Array.new

    @table.each_with_index do |row, i|
      serie_data = chart_serie_data(row[1]['fi'], i, @table.size)
      serie_index = @table.size - (i + 1)

      serie << "{ data: [#{serie_data}], index: #{serie_index} }"
    end

    @chart = Hash.new
    @chart["data"] = serie.join(",")
  end

  def chart_serie_data(xi, index, size)
    data = Array.new(size) { |i| "null" }
    (size - 1).step(index, -1) { |i| data[i] = xi }

    data.join(",")
  end

  def prepare_chart_x_axis
    adjust = @distribution_type == "continuous" ? 1 : 0
    data = Array.new

    @table.each_with_index do |row, index|
      data << Array.new
      (0).upto(index) { |i| data[index] << @table[i + adjust]['xi'] }
    end

    @chart["xAxis"] = data.map{ |a| a.join(",") }
  end

  def calculate_measure_of_dispersion
    adjust = @distribution_type == "continuous" ? 1 : 0

    @table.size.times do |i|
      @table[i + adjust]["variance"] = '%.3f' % (((@table[i + adjust]["xi"] - @mean) ** 2) * @table[i + adjust]["fi"])
    end

    calculate_variance
    calculate_standard_deviation
    calculate_coefficient_of_variation
  end

  def calculate_variance
    divisor = if @collection_type == "population"
      @ranked_data.length
    else
      @ranked_data.length - 1
    end

    variance_sum = @table.map { |h| h[1]["variance"].to_f }.reduce(:+)
    @variance = '%.3f' % (variance_sum / divisor.to_f)
  end

  def calculate_standard_deviation
    @standard_deviation = '%.3f' % (Math.sqrt(@variance.to_f))
  end

  def calculate_coefficient_of_variation
    @coefficient_of_variation = '%.2f' % (((@standard_deviation.to_f) / @mean) * 100)
  end

  def calculate_greater_than(median, standard_deviation, value)
    z_value = calculate_z_value(median, standard_deviation, value)

    probability = if value < median
      (0.5 + z_value) * 100
    else
      (0.5 - z_value) * 100
    end

    probability.round(2)
  end

  def calculate_less_than(median, standard_deviation, value)
    z_value = calculate_z_value(median, standard_deviation, value)

    probability = if value > median
      (0.5 + z_value) * 100
    else
      (0.5 - z_value) * 100
    end

    probability.round(2)
  end

  def calculate_between(median, standard_deviation, less, greater)
    z_less_value = calculate_z_value(median, standard_deviation, less)
    z_greater_value = calculate_z_value(median, standard_deviation, greater)

    probability = if less < median && greater > median
      # less=3, median=5, greater=7
      (z_less_value + z_greater_value) * 100
    elsif less < median && greater == median
      # less=3, median=5, greater=5
      z_less_value * 100
    elsif less < median && greater < median
      # less=1, median=5, greater=3
      (z_less_value - z_greater_value) * 100
    elsif less == median && greater > median
      # less=5, median=5, greater=7
      z_greater_value * 100
    elsif less > median && greater > median
      # less=7, median=5, greater=9
      (z_greater_value - z_less_value) * 100
    end

    probability.round(2)
  end

  def calculate_less_and_greater_than(median, standard_deviation, less, greater)
    less_value = calculate_less_than(median, standard_deviation, less)
    greater_value = calculate_greater_than(median, standard_deviation, greater)

    probability = if less > greater
      (less_value + greater_value) - 100
    else
      less_value + greater_value
    end

    probability.round(2)
  end

  def calculate_z_value(median, standard_deviation, value)
    # Calculate the absolute index
    z_index = ((value - median) / standard_deviation).abs

    return 0.4999 if z_index >= 3.1

    # Round the index (ex: 0.159 => 0.16)
    z_index = z_index.round(2)

    # Find the row on STANDARD_TABLE
    z_row = STANDARD_TABLE[('%.3f' % z_index)[0..2].to_f]

    # Find the column on STANDARD_TABLE
    z_column = ('%.3f' % z_index)[3] || 0

    # Find the STANDARD_TABLE value for the given row/column
    z_row[z_column.to_i]
  end
end

class Array
  def to_sentence
    words_connector = ", "
    two_words_connector = " e "

    case length
      when 0
        ""
      when 1
        self[0].to_s
      when 2
        "#{self[0]}#{two_words_connector}#{self[1]}"
      else
        "#{self[0...-1].join(words_connector)}#{two_words_connector}#{self[-1]}"
    end
  end
end

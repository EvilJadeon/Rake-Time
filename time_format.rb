class TimeFormat
  DATE_FORMATS = { 'year' => '%Y', 'month' => '%m', 'day' => '%d' }.freeze
  TIME_FORMATS = { 'hour' => '%H', 'minute' => '%M', 'second' => '%S' }.freeze

  def initialize(format)
    @foramt = format.split(',')
  end

  def valid?
    unknown_format.empty?
  end

  def unknown_format
    @format.difference(DATE_FORMATS.keys + TIME_FORMATS.keys)
  end

  def time
    date_format = @format.map { |element| DATE_FORMATS[element] }.compact.join('-')
    time_format = @format.map { |element| TIME_FORMATS[element] }.compact.join(':')

    Time.now.strftime("#{date_format} #{time_format}")
  end
end

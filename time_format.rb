# frozen_string_literal: true

class TimeFormat

  FORMATS = { year:   '%Y',
    month:  '%m',
    day:    '%d',
    hour:   '%H',
    minute: '%M',
    second: '%S'
  }

  def initialize(params_string)
    @params_string = params_string
    @accepted_params = []
    @rejected_params = []
  end

  def success?
    @rejected_params.empty?
  end

  def convert_format
    Time.now.strftime(@accepted_params.join('-'))
  end

  def check_format
    params = @params_string.split(',')
    params.each do |param|
      if FORMATS.key?(param.to_sym)
        @accepted_params << FORMATS[param.to_sym]
      else
        @rejected_params << param
      end
    end
  end
end

require 'rack'
require_relative 'time_format'

class App
  def call(env)
    @env = env
    @format = Rack::Utils.parse_query(env['QUERY_STRING'])['format']
    response
  end

  private

  def response
    if @env['REQUEST_METHOD'] != 'GET'
      return [405, {}, ["Wrong request method\n"]]
    end

    if format.nil?
      return [400, {}, ["Format parameter can't be nil\n"]]
    end

    time_format = TimeFormat.new(@format)
    
    if !time_format.valid?
      return [400, {}, ["Unknown time format #{time_format.unknown_format}\n"]]
    end

    [200, {}, ["#{time_format.time}\n"]]
  end
end

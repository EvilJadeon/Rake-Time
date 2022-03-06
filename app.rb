# frozen_string_literal: true

require 'rack'
require_relative 'time_format'

class App
  def call(env)
    request = Rack::Request.new(env)
    request_valid?(request) ? operate_request(request) : response(404, 'not found')
  end

  private

  def operate_request(request)
    params_string = request.params['format']
    date_format = TimeFormat.new(params_string)
    date_format.check_format
    date_format.success? ? response(200, date_format.convert_format) : response(400,"unknown time format #{date_format.rejected_params}")
  end

  def request_valid?(request)
    request.get?
    request.path == '/time'
    request.params['format']
  end

  def response(status, body)
    Rack::Response.new(body, status, {'Content-Type' => 'text/plain'}).finish
  end
end

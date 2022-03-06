# frozen_string_literal: true

require_relative 'app'

use Rack::Reloader, 0

run App.new

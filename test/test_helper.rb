$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "elastic_notifier"
require "vcr"
require "minitest/autorun"

VCR.configure do |config|
  config.cassette_library_dir = 'test/support/vcr'
  config.allow_http_connections_when_no_cassette = true
  config.hook_into :webmock
end

require 'test_helper'

describe ElasticNotifier::Error do
  it 'collects environment information and serializes the error data' do
    exception = StandardError.new("something bad happened")
    exception.set_backtrace(['fake backtrace'])

    error = ElasticNotifier::Error.new(exception)
    attributes = error.to_hash

    assert_equal 'error', attributes[:severity]
    assert Time.parse(attributes[:timestamp])
    refute attributes[:program_name].empty?
    assert attributes[:pid] > 0
    refute attributes[:hostname].empty?
    assert attributes[:ip] =~ /\d+.\d+.\d+.\d+/
    assert_equal 'StandardError', attributes[:data][:name]
    assert_equal 'something bad happened', attributes[:data][:message]
    assert_equal ['fake backtrace'], attributes[:data][:backtrace]
  end
end


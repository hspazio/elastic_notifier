require "test_helper"

describe ElasticNotifier do
  it 'has a version number' do
    refute_nil ::ElasticNotifier::VERSION
  end

  describe 'config' do
    it 'yields the configuration when a block is given' do

    end
  end

  it 'notifies an error to Elastic server' do
    skip
    begin
      raise StandardError, "test error"
    rescue => error
      @error = error
    end

    assert ElasticNotifier.notify(@error)
  end
end

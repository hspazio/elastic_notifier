require "test_helper"

describe ElasticNotifier do
  it 'has a version number' do
    refute_nil ::ElasticNotifier::VERSION
  end

  it 'notifies an error to Elastic server' do
    ElasticNotifier.configure do |config|
      config.url = ENV['ELASTIC_NOTIFIER_URL']
      config.index = :elastic_notifier
      config.type = :signals
      config.klass = ElasticNotifier::Error
    end

    begin
      raise NoMethodError, "test error"
    rescue => error
      @error = error
    end
    result = ElasticNotifier.notify_error(@error)

    assert_equal 'elastic_notifier', result['_index']
    assert_equal 'signals', result['_type']
    assert_equal 'created', result['result']
    refute result['_id'].empty?
  end
end

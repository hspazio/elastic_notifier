require "test_helper"

describe ElasticNotifier do
  it 'has a version number' do
    refute_nil ::ElasticNotifier::VERSION
  end

  it 'notifies an error to Elastic server' do
    ElasticNotifier.configure do |config|
      config.url = 'http://my-kibana-instance.com:9200'
      config.index = :elastic_notifier
      config.type = :signals
    end

    error = NoMethodError.new('test error')
    error.set_backtrace(['test-backtrace'])

    VCR.use_cassette('notify_error') do
      result = ElasticNotifier.notify_error(error)

      assert_equal 'elastic_notifier', result['_index']
      assert_equal 'signals', result['_type']
      assert_equal 'created', result['result']
      refute result['_id'].empty?
    end
  end
end

require "test_helper"

describe ElasticNotifier do
  it 'has a version number' do
    refute_nil ::ElasticNotifier::VERSION
  end

  it 'notifies an error to Elastic server' do
    notifier = ElasticNotifier.new(
      url: 'http://my-kibana-instance.com:9200',
      index: :elastic_notifier,
      type: :signals
    )

    error = NoMethodError.new('test error')
    error.set_backtrace(['test-backtrace'])

    VCR.use_cassette('notify_error') do
      result = notifier.notify_error(error)

      assert_equal 'elastic_notifier', result['_index']
      assert_equal 'signals', result['_type']
      assert_equal 'created', result['result']
      refute result['_id'].empty?
    end
  end

  it 'aliases #notify_error to #call' do
    notifier = ElasticNotifier.new(
      url: 'http://my-kibana-instance.com:9200'
    )

    error = NoMethodError.new('test error')
    error.set_backtrace(['test-backtrace'])

    VCR.use_cassette('notify_error') do
      result = notifier.call(error)

      assert_equal 'elastic_notifier', result['_index']
      assert_equal 'signals', result['_type']
      assert_equal 'created', result['result']
      refute result['_id'].empty?
    end
  end

  it 'overrides the program_name' do
    notifier = ElasticNotifier.new(
      url: 'http://my-kibana-instance.com:9200',
      program_name: 'my-program-name'
    )

    error = NoMethodError.new('test error')
    error.set_backtrace(['test-backtrace'])

    VCR.use_cassette('notify_error_with_overrides') do
      result = notifier.call(error)

      assert_equal 'elastic_notifier', result['_index']
      assert_equal 'signals', result['_type']
      assert_equal 'created', result['result']
      refute result['_id'].empty?
    end
  end
end

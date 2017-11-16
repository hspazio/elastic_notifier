require 'test_helper'

describe ElasticNotifier::Config do
  it 'defines global configurations' do
    ElasticNotifier::Config.url = 'http://example.com'
    ElasticNotifier::Config.index = :my_test_index
    ElasticNotifier::Config.type = :my_test_type
    ElasticNotifier::Config.klass = ElasticNotifier::Error

    assert_equal 'http://example.com', ElasticNotifier::Config.url
    assert_equal :my_test_index, ElasticNotifier::Config.index
    assert_equal :my_test_type, ElasticNotifier::Config.type
    assert_equal ElasticNotifier::Error, ElasticNotifier::Config.klass
  end
end

require 'test_helper'

describe ElasticNotifier::Config do
  it 'defines global configurations' do
    ElasticNotifier::Config.url = 'http://example.com'
    ElasticNotifier::Config.index = :my_test_index
    ElasticNotifier::Config.type = :my_test_type

    assert_equal 'http://example.com', ElasticNotifier::Config.url
    assert_equal :my_test_index, ElasticNotifier::Config.index
    assert_equal :my_test_type, ElasticNotifier::Config.type
  end
end

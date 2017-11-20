require 'test_helper'

describe ExceptionNotification::ElasticSearchNotifier do
  it 'delegates to ElasticNotifier' do
    options = {
      url: 'http://example.com:9200',
      index: 'my_index',
      type: 'my_type'
    }
    notifier = ExceptionNotification::ElasticSearchNotifier.new(options)
    exception = StandardError.new("something bad happened")
    VCR.use_cassette('exception_notification') do
      notifier.call(exception)
    end
  end
end

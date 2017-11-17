require 'test_helper'

describe ExceptionNotification::ElasticSearchNotifier do
  it 'delegates to ElasticNotifier' do
    skip
    options = {
      url: 'http://example.com',
      index: 'my_index',
      type: 'my_type'
    }
    notifier = ExceptionNotification::ElasticSearchNotifier.new(options)
    exception = StandardError.new("something bad happened")
    notifier.call(exception)
  end
end

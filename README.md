# ElasticNotifier

[![Maintainability](https://api.codeclimate.com/v1/badges/92763b5c5c012431d829/maintainability)](https://codeclimate.com/github/hspazio/elastic_notifier/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/92763b5c5c012431d829/test_coverage)](https://codeclimate.com/github/hspazio/elastic_notifier/test_coverage)
[![Build Status](https://travis-ci.org/hspazio/elastic_notifier.svg?branch=master)](https://travis-ci.org/hspazio/elastic_notifier)

ElasticNotifier gem provides a simple API to send error notifications to an Elastic Search instance. 

It can also be used as plug-in for [exception_notification][exception_notification] gem to send error notifications caught by the Rack middleware. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'elastic_notifier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elastic_notifier

## Usage

```ruby
NOTIFIER = ElasticNotifier.new(
  url: "http://myserver.com:9200", # default is http://localhost:9200
  index: "my_custom_index",        # default is :elastic_notifier
  type: "my_document_type"         # default is :signals
)
```

For __Rails__ applications you can add the code above to `config/initializers/elastic_notifier.rb` so it will be available throghout the app.

Then send error notifications as you rescue errors:

```ruby
begin
  # some code that raises an exception
rescue => error
  NOTIFIER.notify_error(error)
end
```

## As ExceptionNotification's Plugin

If you are already using [exception_notification][exception_notification] gem within a Rails app you can use ElasticNotifier out of the box.

In `config/initializers/elastic_notifier.rb`, after initializing the notifier object as described above, you need to register it [as documented here](https://github.com/smartinez87/exception_notification#custom-notifier).

```ruby
notifier = ElasticNotifier.new(url: "http://myserver.com:9200")
ExceptionNotifier.add_notifier :elastic_search, notifier
```

## What information is being sent?

At the time the notifier is invoked it collects some information from the environment, serializes it together with the exception details and sent it to the Elastic instance.

```ruby
{
  severity: "error",
  timestamp: "2017-12-31 23:59:59",
  program_name: "my_app.rb",
  pid: 1345,
  hostname: "myservicename",
  ip: "123.123.123.123",
  data: {
    name: "NoMethodError",
    message: "undefined method `test` for nil:NilClass",
    backtrace: [...]
  }
}

```

## Contributing

Bug reports and pull requests are very welcome. Please be aware that you are expected to follow the [code of conduct](https://github.com/hspazio/elastic_notifier/blob/master/CODE_OF_CONDUCT.md).

## License

Copyright (c) 2017 Fabio Pitino, released under the [MIT license](http://www.opensource.org/licenses/MIT).

[exception_notification]: https://github.com/smartinez87/exception_notification

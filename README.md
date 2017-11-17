# ElasticNotifier

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/elastic_notifier`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'elastic_notifier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elastic_notifier

## As a standalone notifier

Use the code below if you want to override the default configurations. For __Rails__ applications you can add the snippet to `config/initializers/elastic_notifier.rb`

```ruby
ElasticNotifier.configure do |config|
  # default url from environment variable: ENV['ELASTIC_NOTIFIER_URL']
  config.url = 'http://myelasticsearch.server.com:9200' 
  config.index = :my_custom_index  # default is :elastic_notifier
  config.type = :my_document_type  # default is :signals
end
```
Then send error notifications as you rescue errors:

```ruby
begin
  # some code that raises an exception
rescue => error
  ElasticNotifier.notify_error(error)
end
```

## As ExceptionNotification's Plugin

If you are already using [exception_notification][exception_notification] gem within a Rails app you can use ElasticNotifier's plugin.

Simply add the configurations to the `ExceptionNotification::Rack` middleware [as documented here](https://github.com/smartinez87/exception_notification#rails).

```ruby
Rails.application.config.middleware.use ExceptionNotification::Rack,
  :email => {
    :email_prefix => "[PREFIX] ",
    :sender_address => %{"notifier" <notifier@example.com>},
    :exception_recipients => %w{exceptions@example.com}
  },
  :elastic_search => {
    :url => 'http://myelasticsearch.server.com:9200',
    :index => 'elastic_notifier',
    :username => 'signals'
  }
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hspazio/elastic_notifier.


[exception_notification]: https://github.com/smartinez87/exception_notification

## License

Copyright (c) 2017 Fabio Pitino, released under the [MIT license](http://www.opensource.org/licenses/MIT).

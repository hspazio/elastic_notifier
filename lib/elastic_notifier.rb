require 'elasticsearch/persistence'
require 'socket'

require 'elastic_notifier/signal'
require 'elastic_notifier/error'
require 'elastic_notifier/config'
require 'elastic_notifier/version'
require 'exception_notification'

module ElasticNotifier
  def self.configure
    yield Config
  end

  def self.notify_error(exception)
    Notifier.new.notify_error(exception)
  end

  class Notifier
    def initialize(options = {})
      url = options.fetch(:url, Config.url || ENV['ELASTIC_NOTIFIER_URL'])
      index = options.fetch(:index, Config.index)
      type = options.fetch(:type, Config.type)

      @repository = Elasticsearch::Persistence::Repository.new do
        client Elasticsearch::Client.new url: url, log: true
        index  index
        type   type
      end
    end

    # TODO: add options data to the Error json
    def notify_error(exception, options = {})
      error = Error.new(exception).to_hash
      @repository.save(error)
    end
  end
end


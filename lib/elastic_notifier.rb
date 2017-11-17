require 'elasticsearch/persistence'
require 'socket'

require 'elastic_notifier/signal'
require 'elastic_notifier/error'
require 'elastic_notifier/config'
require 'elastic_notifier/version'

module ElasticNotifier
  def self.configure
    yield Config
  end

  def self.notify_error(exception)
    error = Error.new(exception).to_hash
    repository.save(error)
  end

  def self.repository
    @repo ||= Elasticsearch::Persistence::Repository.new do
      client Elasticsearch::Client.new url: Config.url, log: Config.log
      index  Config.index
      type   Config.type
    end
  end
end


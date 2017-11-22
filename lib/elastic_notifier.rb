require 'elasticsearch/persistence'
require 'typhoeus/adapters/faraday'
require 'socket'

require 'elastic_notifier/signal'
require 'elastic_notifier/error'
require 'elastic_notifier/version'

module ElasticNotifier
  def self.new(options = {})
    Notifier.new(options)
  end

  class Notifier
    def initialize(options = {})
      url = options[:url]
      index = options.fetch(:index, :elastic_notifier)
      type = options.fetch(:type, :signals)

      @repo ||= Elasticsearch::Persistence::Repository.new do
        client Elasticsearch::Client.new url: url
        index  index
        type   type
      end
    end

    # TODO: add options data to the Error json
    def notify_error(exception, options = {})
      error = Error.new(exception).to_hash
      @repo.save(error)
    end
    alias call notify_error
  end
end


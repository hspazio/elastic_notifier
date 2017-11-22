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
    def initialize(options)
      @repo ||= Elasticsearch::Persistence::Repository.new do
        client Elasticsearch::Client.new url: options[:url]
        index  options.fetch(:index, :elastic_notifier)
        type   options.fetch(:type, :signals)
      end
      @options = options
    end

    def notify_error(exception, params = {})
      overrides = {
        program_name: @options[:program_name]
      }
      error = Error.new(exception, overrides).to_hash
      @repo.save(error)
    end
    alias call notify_error
  end
end


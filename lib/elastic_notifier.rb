require 'elasticsearch/persistence'

require "elastic_notifier/version"

module ElasticNotifier
  def self.notify(exception)
    error = Error.new(exception).to_hash
    repository.save(error)
  end

  def self.repository
    @repo ||= Elasticsearch::Persistence::Repository.new do
      client Elasticsearch::Client.new url: ENV['KIBANA_URL_DEV'], log: true

      index :elastic_notifier
      type :error
      klass ElasticNotifier::Error
    end
  end

  class Error
    attr_reader :attributes

    def initialize(error)
      @error = error
    end

    def to_hash
      { 
        severity: 'error',
        timestamp: Time.now.strftime('%Y-%m-%dT%H:%M:%S'),
        program_name: $0,
        pid: $$,
        data: {
          name: @error.class.name,
          message: @error.message,
          backtrace: @error.backtrace
        }
      }
    end
  end
end


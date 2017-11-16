module ElasticNotifier
  class Config
    class << self
      attr_accessor :url
      attr_accessor :index
      attr_accessor :type
      attr_accessor :klass
      attr_accessor :log
    end

    @url   ||= ENV['ELASTIC_NOTIFIER_URL']
    @index ||= :elastic_notifier
    @type  ||= :signals
    @klass ||= ElasticNotifier::Error
    @log   ||= false
  end
end

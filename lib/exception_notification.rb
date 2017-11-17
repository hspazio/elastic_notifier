module ExceptionNotification
  class ElasticSearchNotifier
    def initialize(options)
      @notifier = ElasticNotifier::Notifier.new(options)
    end

    def call(exception, options={})
      @notifier.notify_error(exception, options)
    end
  end
end

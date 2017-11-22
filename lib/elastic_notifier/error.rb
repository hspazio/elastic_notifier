module ElasticNotifier
  class Error < Signal
    attr_reader :attributes

    def initialize(error, overrides = {})
      super(overrides)
      @error = error
    end

    def severity
      'error'
    end

    def data
      { 
        name: @error.class.name,
        message: @error.message,
        backtrace: @error.backtrace
      }
    end
  end
end

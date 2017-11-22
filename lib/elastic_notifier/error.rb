module ElasticNotifier
  class Error < Signal
    attr_reader :attributes

    def initialize(error, program_name:)
      super(program_name: program_name)
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

module ElasticNotifier
  class Signal
    attr_reader :attributes

    def initialize(program_name:)
      @pid = Process.pid
      @hostname = Socket.gethostname
      @ip = find_ip_address
      @timestamp = Time.now.strftime('%Y-%m-%dT%H:%M:%S')
      @program_name = program_name
    end

    def to_hash
      { 
        severity: severity,
        timestamp: @timestamp,
        program_name: @program_name,
        pid: @pid,
        hostname: @hostname,
        ip: @ip,
        data: data
      }
    end

    def severity
      raise NotImplementedError
    end

    def data
      raise NotImplementedError
    end

    private 

    def find_ip_address
      Socket.ip_address_list.find { |ip| ip.ipv4? && !ip.ipv4_loopback? }.ip_address
    end
  end
end

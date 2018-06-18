module ElasticNotifier
  class Signal
    attr_reader :attributes

    def initialize(overrides = {})
      @pid = Process.pid
      @hostname = Socket.gethostname
      @ip = find_ip_address
      @timestamp = Time.now.strftime('%Y-%m-%dT%H:%M:%S')
      @program_name = $PROGRAM_NAME
      @overrides = overrides
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
      }.merge(@overrides)
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

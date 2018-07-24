module TencentCosSdk
    class Configuration
        attr_accessor :secret_id, :secret_key, :host, :parent_path
    end

    class << self
        def configure
            @conf ||= Configuration.new
            yield @conf
            @conf
        end

        def conf
            @conf
        end
    end
end

require "tencent_cos_sdk/version"
require "tencent_cos_sdk/configuration"
require "tencent_cos_sdk/request"

module TencentCosSdk
    class << self
        #
        # TencentCosSdk.put '1/abc.txt', body: 'abc123'
        # TencentCosSdk.put '1/abc.txt', file: './xyz.txt'
        #
        def put path, options = {}
            Request.new(options.merge http_method: 'put', uri: uri(path), sign: true).execute
        end

        #
        # TencentCosSdk.get '1/abc.txt'
        #
        def get path, options = {}
            Request.new(options.merge http_method: 'get', uri: uri(path)).execute
        end

        #
        # TencentCosSdk.delete '1/abc.txt'
        #
        def delete path, options = {}
            Request.new(options.merge http_method: 'delete', uri: uri(path), sign: true).execute
        end

    private

        def uri path
            File.join TencentCosSdk.conf.parent_path, path
        end
    end
end

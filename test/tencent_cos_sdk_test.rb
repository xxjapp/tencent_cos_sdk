require "test_helper"

class TencentCosSdkTest < Minitest::Test
    def setup
        TencentCosSdk.configure do |conf|
            conf.app_id         = ENV['APP_ID_1']
            conf.secret_id      = ENV['SECRET_ID_1']
            conf.secret_key     = ENV['SECRET_KEY_1']
            conf.host           = ENV['HOST_1']
            conf.parent_path    = '/app_name_1'
        end

        @path = '1/abc.txt'
    end

    def test_configure_should_be_valid
        [:app_id, :secret_id, :secret_key, :host, :parent_path].each do |attr|
            assert TencentCosSdk.conf.send(attr) != nil
        end
    end

    def test_that_it_has_a_version_number
        refute_nil ::TencentCosSdk::VERSION
    end

    def test_put_body
        TencentCosSdk.put @path, body: 'abc123'
    end

    def test_put_by_file
        TencentCosSdk.put @path, file: __FILE__
    end

    def test_get
        TencentCosSdk.get @path
    end

    def test_delete
        TencentCosSdk.delete @path
    end
end

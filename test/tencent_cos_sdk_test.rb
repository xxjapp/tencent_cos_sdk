require "test_helper"

class TencentCosSdkTest < Minitest::Test
    def setup
        TencentCosSdk.configure do |conf|
            conf.secret_id      = ENV['SECRET_ID_1']
            conf.secret_key     = ENV['SECRET_KEY_1']
            conf.host           = ENV['HOST_1']
            conf.parent_path    = '/app_name_1'
        end

        @path = '1/abc.txt'
    end

    def test_that_it_has_a_version_number
        refute_nil ::TencentCosSdk::VERSION
    end

    def test_conf_should_be_valid
        [:secret_id, :secret_key, :host].each do |attr|
            assert TencentCosSdk.conf.send(attr) != nil
        end
    end

    def test_put_by_body
        response = TencentCosSdk.put @path, body: 'abc123'
        assert_equal 200, response.code
    end

    def test_put_by_file
        response = TencentCosSdk.put @path, file: __FILE__
        assert_equal 200, response.code
    end

    def test_get
        TencentCosSdk.put @path, body: 'abc123'

        response = TencentCosSdk.get @path
        assert_equal 200, response.code
    end

    def test_delete
        TencentCosSdk.put @path, body: 'abc123'

        response = TencentCosSdk.delete @path
        assert_equal 204, response.code
    end
end

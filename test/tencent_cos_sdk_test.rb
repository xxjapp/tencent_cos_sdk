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

    def test_get_authorization_1
        TencentCosSdk.configure do |conf|
            conf.parent_path    = '/aimee'
        end

        request = TencentCosSdk::Request.new \
            http_method: 'put',
            path: 'uploads/micropost/picture/22/zh-CN.png',
            file: __FILE__,
            sign: true,
            sign_time: '1532755230;1532762430'

        assert_equal 'a75998e6a65e4f1be4063ab778d71c2e589ad6db', request.description.match(%r(q-signature=(\w+)))[1]
    end

    def test_get_authorization_2
        TencentCosSdk.configure do |conf|
            conf.parent_path    = '/aimee'
        end

        request = TencentCosSdk::Request.new \
            http_method: 'put',
            path: 'uploads/micropost/picture/34/zh-CN.png',
            file: __FILE__,
            sign: true,
            sign_time: '1532755144;1532762344'

        assert_equal '0ee22566446b933e52d716fe7bd3fdae4e49b9fa', request.description.match(%r(q-signature=(\w+)))[1]
    end
end

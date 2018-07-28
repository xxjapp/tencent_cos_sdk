require 'cgi'
require 'openssl'

module TencentCosSdk
    class << self
        def uri(path)
            "#{TencentCosSdk.conf.parent_path.to_s}/#{path}"
        end

        def url(path)
            "https://#{TencentCosSdk.conf.host}#{uri path}"
        end
    end

    class Request
        def get_authorization
            sign_time           = options[:sign_time] || "#{Time.now.to_i - 3600};#{Time.now.to_i + 3600}"

            sign_key            = OpenSSL::HMAC.hexdigest('sha1', TencentCosSdk.conf.secret_key, sign_time)
            http_string         = get_http_string
            sha1ed_http_string  = Digest::SHA1.hexdigest http_string
            string_to_sign      = "sha1\n#{sign_time}\n#{sha1ed_http_string}\n"
            signature           = OpenSSL::HMAC.hexdigest('sha1', sign_key, string_to_sign)

            {
                'q-sign-algorithm'  => 'sha1',
                'q-ak'              => TencentCosSdk.conf.secret_id,
                'q-sign-time'       => sign_time,
                'q-key-time'        => sign_time,
                'q-header-list'     => get_header_list,
                'q-url-param-list'  => get_param_list,
                'q-signature'       => signature
            }.map do |k, v|
                "#{k}=#{v}"
            end.join('&')
        end

        def get_http_string
            http_string  = http_method + "\n"
            http_string += TencentCosSdk.uri(@path) + "\n"
            http_string += get_params + "\n"
            http_string += get_headers + "\n"
        end

        # NOTE: 暂不需要
        def get_params
            ''
        end

        # NOTE: 暂不需要
        def get_param_list
            ''
        end

        def get_headers
            return '' if !headers

            headers.map do |k, v|
                "#{k.downcase}=#{CGI::escape(v)}"
            end.sort.join('&')
        end

        def get_header_list
            return '' if !headers

            headers.map do |k, v|
                k.downcase
            end.sort.join(';')
        end
    end
end

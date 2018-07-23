require 'colorize'
require 'rest-client'
require 'tencent_cos_sdk/utils'

module TencentCosSdk
    class Request
        attr_accessor :http_method, :uri, :headers, :body, :file
        attr_accessor :response, :time_used

        def initialize options
            self.http_method    = options[:http_method]
            self.uri            = options[:uri]
            self.headers        = options[:headers] || {}
            self.body           = options[:body]
            self.file           = options[:file]

            self.headers['Content-Type']  = 'application/octet-stream'  if http_method == 'put'
            self.headers['Authorization'] = get_authorization           if options[:sign]
        end

        def execute
            start_time = Time.now

            begin
                puts description

                options = {
                    method:     http_method,
                    url:        "https://#{TencentCosSdk.conf.host}#{uri}",
                    headers:    headers,
                    verify_ssl: false
                }

                options[:payload] = body            if body
                options[:payload] = IO.binread file if file

                self.response = RestClient::Request.execute options
            rescue => e
                puts e.backtrace.first + ": #{e.message} (#{e.class})"
                e.backtrace[1..-1].each { |m| puts "\tfrom #{m}" }

                raise e if !e.response
                self.response = e.response
            ensure
                end_time = Time.now
                self.time_used = (end_time - start_time)
                puts response_description
            end

            file_path = uri["#{TencentCosSdk.conf.parent_path}/".length..-1]

            m = /attachment; filename\*="UTF-8''(.+)"/.match response.headers[:content_disposition]
            FileUtils.mkdir_p File.dirname(file_path)
            IO.binwrite(file_path, response) if m

            response
        end

    private

        def description
            s = "\n\n"
            s << "#{http_method.upcase} #{uri} HTTP/1.1\n".light_magenta

            headers.each do |k, v|
                s << "#{k}: #{v}\n".red
            end if headers

            s << "\n"
            s << body << "\n" if body

            return s
        end

        def response_description
            return nil if !response

            s = "%s | %.3f sec\n".light_magenta % [response.description.chomp, time_used]

            max_key_size = response.headers.max_by do |k, v|
                k.size
            end[0].size

            s << response.headers.map do |k, v|
                "%#{max_key_size}s".green % k + ': ' + v.green + "\n"
            end.join

            s << response.to_s if response.headers[:content_type] == 'application/xml'
            return s
        end
    end
end

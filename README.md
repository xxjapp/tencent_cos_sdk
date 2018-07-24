# TencentCosSdk

Tencent cos sdk for ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tencent_cos_sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tencent_cos_sdk

## Usage

1. Configuration

```ruby
TencentCosSdk.configure do |conf|
    conf.secret_id      = ENV['SECRET_ID_1']
    conf.secret_key     = ENV['SECRET_KEY_1']
    conf.host           = ENV['HOST_1']
    conf.parent_path    = '/app_name_1'
end
```

2. Call APIs
```ruby
response = TencentCosSdk.put '1/abc.txt', body: 'abc123'
response = TencentCosSdk.put '1/abc.txt', file: __FILE__
response = TencentCosSdk.get '1/abc.txt'
response = TencentCosSdk.delete '1/abc.txt'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tencent_cos_sdk. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TencentCosSdk project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/tencent_cos_sdk/blob/master/CODE_OF_CONDUCT.md).

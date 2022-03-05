# Klaytn

Interact with transactions, smart contracts, and NFTs on the Klaytn blockchain (https://www.klaytn.com/) in pure Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'klaytn'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install klaytn

## Usage

```
# todo
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

After installing the gem, run `rspec` to run the test suite. **Important**: you must first authenticate with KAS via:
```
export KAS_ACCESS_KEY=KASxxx
export KAS_SECRET_ACCESS_KEY=yyy
export KAS_ACCOUNT_WALLET_ADDRESS=0x0xxx
export KAS_ACCOUNT_POOL_KRN=krn:ChainID:wallet:xxx
```

Without these local `ENV` variables, most tests will fail.

Sometimes `rspec` doesn't load variables, even if you can `$echo` them. To prevent subtle bugs, run the test suite via:
```
KAS_ACCESS_KEY="KASxxx" KAS_SECRET_ACCESS_KEY="yyy" KAS_ACCOUNT_WALLET_ADDRESS="0x0xxx" KAS_ACCOUNT_POOL_KRN="krn:ChainID:wallet:xxx" rake spec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/OojuTeam/klaytn-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/OojuTeam/klaytn-ruby/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Klaytn project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/OojuTeam/klaytn-ruby/blob/master/CODE_OF_CONDUCT.md).

# Klaytn Ruby Library
Execute transactions and interact with smart contracts, wallets, and NFT tokens on the [Klaytn blockchain](https://www.klaytn.com/). Most functions require KAS Console credentials and KLAY tokens (inside a KAS Account Pool wallet) to pay transaction fees. Created by [ooju.xyz](https://ooju.xyz).

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
This library is modeled off the [KAS Wallet API](https://refs.klaytnapi.com/en/wallet/latest), but is not an exhaustive implementation. Below are the core features.

**Client authentication**
```rb
opts = {
  kas_access_key: 'KASxxx',
  kas_secret_access_key: 'yyy',
  kas_account_wallet_address: '0x0x',
  kas_account_pool_krn: 'krn:ChainID:wallet:xxx',
  chain_id: 1001 # testnet (baobab) - 1001; mainnet (cypress) - 8217
}
```

**Transactions**
```rb
client = Klaytn::Transaction.new(opts)

# fetch a transaction
result = client.get('0x00301b2b1c09ed43d4b59cbcd5610ebfe17a48215e6f6de10693eb368a489baa') # => {"blockHash"=>"0x597fb..."}

# create a transaction
result = client.send('0x00E7b604e9493d53749e7b7b9e39F313d9F9890a', 1, { memo: 'sending 1 peb' }) # => {"from"=>"0x..."}
```

**Wallets**
```rb
client = Klaytn::Wallet.new # no authentication required

# get a wallet
result = client.get('0x00e7b604e9493d53749e7b7b9e39f313d9f9890a') # => {"success"=>true, "code"=>0, "result"=> {"..."}

# get a wallet's KLAY balance
result = client.get_balance('0x00e7b604e9493d53749e7b7b9e39f313d9f9890a') # => 301.52 (KLAY)
```

**Tokens**
```rb
# instantiation requires additional params
opts = opts.merge(contract_address: '0xbceaa2fa50fef79bb5c4b2fc887dbdd3b96130b7')
client = Klaytn::Token.new(opts)

# get a token
result = client.get(1) # => {"tokenId"=>"0x1", "owner"=>"0x58e0cc86..."}
```

**Contracts**
```rb
# deploy a contract
client = Klaytn::Contract.new(opts)
result = client.deploy('<bytecode>') # => {"from"=>"0x6e1f42c1e..."}

# interact with a deployed contract
opts = opts.merge(
  abi: [{...}],
  contract_address: '0xbceaa2fa50fef79bb5c4b2fc887dbdd3b96130b7'
)
client = Klaytn::Contract.new(opts)
result = client.invoke_function('addAddressToWhitelist', ['0x00E7b604e9493d53749e7b7b9e39F313d9F9890a']) # => {"from"=>"0x3f71cde4246cb..."}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

After installing the gem, run `rspec` to run the test suite. **Important**: you must first authenticate with KAS via:
```
export KAS_ACCESS_KEY=KASxxx
export KAS_SECRET_ACCESS_KEY=yyy
export KAS_ACCOUNT_WALLET_ADDRESS=0x0x
export KAS_ACCOUNT_POOL_KRN=krn:ChainID:wallet:xxx
```

Without these local `ENV` variables, most tests will fail.

Sometimes `rspec` doesn't load variables, even if you can `$echo` them. To prevent subtle bugs, run the test suite via:
```
KAS_ACCESS_KEY="KASxxx" KAS_SECRET_ACCESS_KEY="yyy" KAS_ACCOUNT_WALLET_ADDRESS="0x0x" KAS_ACCOUNT_POOL_KRN="krn:ChainID:wallet:xxx" rake spec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/OojuTeam/klaytn-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/OojuTeam/klaytn-ruby/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Klaytn Ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/OojuTeam/klaytn-ruby/blob/master/CODE_OF_CONDUCT.md).

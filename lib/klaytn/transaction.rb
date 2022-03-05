module Klaytn
  class Transaction < Client
    BASE_URL = 'https://wallet-api.klaytnapi.com/v2/tx'.freeze

    attr_reader :kas_account_wallet_address, :encoder

    def initialize(opts)
      @kas_account_wallet_address = opts[:kas_account_wallet_address] # created via KAS > Service > Wallet > Account Pool > Create Account Pool > Create Account
      @encoder = Encoder.new
      super
    end

    def get(hash)
      resp = HTTParty.get(BASE_URL + "/#{hash}", headers: headers, basic_auth: basic_auth)
      JSON.parse(resp.body)
    end

    def send(address, amount_in_peb, opts = {})
      should_submit = opts[:submit] == false ? false : true
      body = {
        from: kas_account_wallet_address,
        to: address,
        value: encoder.encode_uint(amount_in_peb), # '0x0' = 0 KLAY, '0x4563918244f40000' = 5 KLAY
        memo: opts[:memo], # can be a text note; viewable on Klaytn Scope!
        gas: opts[:gas] || 200000, # not required, default is 1,000,000 if excluded
        submit: should_submit # create real transaction by default
      }

      resp = HTTParty.post(BASE_URL + '/value', body: body.to_json, headers: headers, basic_auth: basic_auth)
      JSON.parse(resp.body)
    end
  end
end

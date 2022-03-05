module Klaytn
  class Transaction < Client
    BASE_URL = 'https://wallet-api.klaytnapi.com/v2/tx'.freeze

    attr_reader :kas_account_wallet_address, :kas_account_pool_krn, :encoder

    def initialize(opts)
      @kas_account_wallet_address = opts[:kas_account_wallet_address] # created via KAS > Service > Wallet > Account Pool > Create Account Pool > Create Account
      @kas_account_pool_krn = opts[:kas_account_pool_krn]
      @encoder = Encoder.new
      super
    end

    def get(hash)
      resp = HTTParty.get(BASE_URL + "/#{hash}", headers: headers, basic_auth: basic_auth)
      JSON.parse(resp.body)
    end

    def send(address, amount_in_peb, opts = {})
      raise MISSING_ACCOUNT_WALLET if kas_account_wallet_address.blank?
      raise MISSING_ACCOUNT_POOL_KRN if kas_account_pool_krn.blank?

      body = {
        from: kas_account_wallet_address,
        to: address,
        value: encoder.encode_integer(amount_in_peb), # '0x0' = 0 KLAY, '0x4563918244f40000' = 5 KLAY
        memo: opts[:memo], # can be a text note; viewable on Klaytn Scope!
        gas: opts[:gas] || 200000, # not required, default is 1,000,000 if excluded
        submit: should_submit?(opts) # create real transaction by default
      }

      resp = HTTParty.post(BASE_URL + '/value', body: body.to_json, headers: headers.merge('x-krn' => kas_account_pool_krn), basic_auth: basic_auth)
      JSON.parse(resp.body)
    end

    def should_submit?(opts)
      opts[:submit] == false ? false : true
    end
  end
end

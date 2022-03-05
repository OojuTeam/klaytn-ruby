module Klaytn
  class Contract < Client
    MISSING_ACCOUNT_WALLET_MSG = 'Please provide a KAS Account wallet to pay for transactions.' # created via KAS > Service > Wallet > Account Pool > Create Account Pool > Create Account
    MISSING_ACCOUNT_POOL_KRN = 'Please provide a KAS Account Pool KRN id to finish linking your KAS Wallet (ex: krn:XXXX:wallet:yyyy...).' # KAS > Service > Wallet > Account Pool > KRN
    BASE_URL = 'https://wallet-api.klaytnapi.com/v2/tx/contract'.freeze

    attr_reader :kas_account_wallet_address, :kas_account_pool_krn, :encoder

    def initialize(opts)
      raise MISSING_ACCOUNT_WALLET_MSG if opts[:kas_account_wallet_address].blank?
      raise MISSING_ACCOUNT_POOL_KRN if opts[:kas_account_pool_krn].blank?

      @kas_account_wallet_address = opts[:kas_account_wallet_address]
      @kas_account_pool_krn = opts[:kas_account_pool_krn]
      @encoder = Encoder.new

      super
    end

    def deploy(bytecode, submit: true)
      body = {
        from: kas_account_wallet_address, # must be created inside KAS console > Account Pool, and MUST be capital version from Klaytn Scope!
        input: bytecode,
        submit: submit
      }

      resp = HTTParty.post(BASE_URL + '/deploy', body: body.to_json, headers: headers, basic_auth: basic_auth)
      JSON.parse(resp.body)
    end

    def headers
      super.merge('x-krn' => kas_account_pool_krn)
    end
  end
end

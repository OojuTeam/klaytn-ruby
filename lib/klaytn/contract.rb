module Klaytn
  class Contract < Client
    MISSING_ACCOUNT_WALLET = 'Please provide a KAS Account wallet to pay for transactions.'.freeze # created via KAS > Service > Wallet > Account Pool > Create Account Pool > Create Account
    MISSING_ACCOUNT_POOL_KRN = 'Please provide a KAS Account Pool KRN id to finish linking your KAS Wallet (ex: krn:XXXX:wallet:yyyy...).'.freeze # KAS > Service > Wallet > Account Pool > KRN
    MISSING_ABI = 'Please provide the contract ABI, an array-like object returned by the compiler.'.freeze
    FUNCTION_NOT_FOUND = 'Function with definition XXX not found.'.freeze
    BASE_URL = 'https://wallet-api.klaytnapi.com/v2/tx/contract'.freeze

    attr_reader :kas_account_wallet_address, :kas_account_pool_krn, :abi, :encoder

    def initialize(opts)
      raise MISSING_ACCOUNT_WALLET if opts[:kas_account_wallet_address].blank?
      raise MISSING_ACCOUNT_POOL_KRN if opts[:kas_account_pool_krn].blank?

      @kas_account_wallet_address = opts[:kas_account_wallet_address]
      @kas_account_pool_krn = opts[:kas_account_pool_krn]
      @abi = opts[:abi]

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

    ## DEPRECATE: definition ex: 'addAddressToWhitelist(address)' - string literal Solidity function definition
    # definition ex: 'addAddressToWhitelist' - string literal Solidity function definition, without parameters/parens
    # inputs ex: [ OpenStruct.new({ "internalType": "address", "name": "addr", "type": "address" }) ] - array of dot-notation object from ABI
    # params ex: ['0x0xxxx'] - array of arguments accepted by function

    def invoke_function(definition, inputs, params, submit: true)
      raise MISSING_CONTRACT if contract_address.blank?
      raise MISSING_ABI if abi.blank?

      found_function = abi.filter {|input| input[:name] == definition }.first
      raise FUNCTION_NOT_FOUND.gsub('XXX', definition) if found_function.nil?

      built_defintion = "#{definition}(#{found_function[:inputs].map {|i| i[:type]}.join(',')})"
      built_inputs = found_function[:inputs].map { |i| OpenStruct.new(i) }

      body = function_body_builder(built_defintion, built_inputs, params)
      resp = HTTParty.post(BASE_URL + '/execute', body: body.to_json, headers: headers, basic_auth: basic_auth)
      JSON.parse(resp.body)
    end

    def function_body_builder(definition, inputs, params, submit)
      {
        from: kas_account_wallet_address,
        to: contract_address,
        input: encoder.encode_function(definition, inputs, params),
        gas: 8500000, # 'gas' parameter not required, possibly better to exclude
        submit: submit
      }
    end

    def headers
      super.merge('x-krn' => kas_account_pool_krn)
    end
  end
end

module Klaytn
  class Client
    INVALID_CLIENT_MSG = 'No params provided - please provide a contract address, ABI, KAS credentials, etc'.freeze

    attr_accessor :contract_address, :abi, :kas_access_key, :kas_secret_access_key

    def initialize(opts = {})
      raise INVALID_CLIENT_MSG if opts == {}

      @contract_address = opts[:contract_address]
      @abi = opts[:abi]
      @kas_access_key = opts[:kas_access_key]
      @kas_secret_access_key = opts[:kas_secret_access_key]
    end
  end
end

module Klaytn
  class Client
    INVALID_CLIENT_MSG = 'No params provided - please provide a contract address, ABI, KAS credentials, etc'.freeze
    MISSING_KAS_MSG = 'KAS credentials missing'.freeze
    MISSING_CONTRACT_MSG = 'Please provide a deployed smart contract address.'.freeze

    attr_accessor :contract_address, :abi
    attr_reader :chain_id, :headers, :basic_auth

    def initialize(opts = {})
      raise INVALID_CLIENT_MSG if opts == {}

      @contract_address = opts[:contract_address]

      @chain_id = setup_chain_id(opts)
      @headers = setup_headers
      @basic_auth = setup_basic_auth(opts)
    end

    def setup_chain_id(opts)
      opts[:chain_id] || 1001 # default to baobab testnet
    end

    def setup_headers
      Authentication.new.headers(chain_id)
    end

    def setup_basic_auth(opts)
      raise MISSING_KAS_MSG unless opts[:kas_access_key].present? && opts[:kas_secret_access_key].present?
      Authentication.new.auth_params(opts[:kas_access_key], opts[:kas_secret_access_key])
    end
  end
end

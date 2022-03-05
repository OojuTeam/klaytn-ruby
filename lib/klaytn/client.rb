module Klaytn
  class Client < Base
    attr_reader :contract_address, :chain_id, :headers, :basic_auth

    def initialize(opts = {})
      raise INVALID_CLIENT if opts == {}

      @contract_address = opts[:contract_address]
      @chain_id = setup_chain_id(opts)
      @headers = Authentication.new.headers(chain_id)
      @basic_auth = setup_basic_auth(opts)
    end

    def setup_chain_id(opts)
      opts[:chain_id] || 1001 # default to baobab testnet
    end

    def setup_basic_auth(opts)
      raise MISSING_KAS_CREDS unless opts[:kas_access_key].present? && opts[:kas_secret_access_key].present?
      Authentication.new.auth_params(opts[:kas_access_key], opts[:kas_secret_access_key])
    end
  end
end

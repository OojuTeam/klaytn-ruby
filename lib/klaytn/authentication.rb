module Klaytn
  class Authentication
    def auth_params(kas_access_key, kas_secret_access_key)
      { username: kas_access_key, password: kas_secret_access_key }
    end

    def headers(chain_id)
      { 'x-chain-id' => chain_id.to_s } # chain id must be string!
    end
  end
end

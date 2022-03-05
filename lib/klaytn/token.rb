module Klaytn
  class Token < Client
    BASE_URL = 'https://th-api.klaytnapi.com/v2/contract/nft'.freeze

    attr_reader :encoder

    def initialize(opts = {})
      raise MISSING_CONTRACT_MSG if opts[:contract_address].blank?

      @encoder = Encoder.new
      super
    end

    def get(token_id)
      url = BASE_URL + "/#{contract_address}/token/#{encoded_token_id(token_id)}"
      resp = HTTParty.get(url, headers: headers, basic_auth: basic_auth)
      JSON.parse(resp.body)
    end

    def encoded_token_id(token_id)
      encoder.encode_uint(token_id)
    end
  end
end

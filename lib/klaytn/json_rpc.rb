module Klaytn
  class JsonRpc < Client
    BASE_URL = 'https://node-api.klaytnapi.com/v1/klaytn'.freeze

    def invoke_function(opts)
      raise MISSING_JSONRPC_METHOD if opts[:method].blank?

      body = function_body_builder(opts)
      resp = HTTParty.post(BASE_URL, body: body.to_json, headers: headers.merge('content-type' => 'application/json'), basic_auth: basic_auth)
      JSON.parse(resp.body)
    end

    def function_body_builder(opts)
      {
        id: opts[:id] || 1,
        jsonrpc: opts[:jsonrpc_version] || "2.0",
        method: opts[:method], # => klay_isContractAccount
        params: opts[:params] # => ["0x4319c81f7894f60c70600cf29ee440ed62e7401e", "earliest"]
      }
    end
  end
end

module Klaytn
  class Wallet < Client
    BASE_URL = 'https://api-cypress-v2.scope.klaytn.com/v2/accounts'.freeze
    PEB_DIVISOR = 1000000000000000000.freeze # friendly 'get_balance' result, ex: "5" == 5 KLAY

    attr_reader :divisor

    # no params needed, overrides Klaytn::Client
    def initialize(peb_divisor: true)
      @divisor = peb_divisor ? PEB_DIVISOR : 1
    end

    def get(address)
      resp = HTTParty.get(BASE_URL + "/#{address}", headers: headers)
      data = JSON.parse(resp.body)
    rescue => e
      raise e.message
    end

    def get_balance(address)
      data = get(address)
      data.dig('result', 'balance').to_f / divisor
    rescue => e
      raise e.message
    end

    def headers
      { origin: 'https://scope.klaytn.com' }
    end
  end
end

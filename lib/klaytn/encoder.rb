module Klaytn
  class Encoder
    def encode_function(definition, inputs, params)
      prefix = '0x'
      str = Ethereum::Function.calc_id(definition) # ex: "getEarnout(uint256)"
      num = Ethereum::Encoder.new.encode_arguments(inputs, params) # ex: [1], or [1,500]

      "#{prefix}#{str}#{num}"
    end

    def encode_uint(integer) # ex: 5000000000000000000 (5 KLAY) => 0x4563918244f40000
      return '0x0' if integer.zero?
      long = Ethereum::Encoder.new.encode_uint(integer)
      '0x' + long.sub!(/^[0]+/,'')
    end
  end
end

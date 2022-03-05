module Klaytn
  class Decoder
    def decode_uint(encoded_uint) # ex: 0x4563918244f40000 => 5000000000000000000 (5 KLAY)
      Ethereum::Decoder.new.decode_uint(encoded_uint)
    end
  end
end

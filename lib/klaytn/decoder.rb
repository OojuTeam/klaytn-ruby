module Klaytn
  class Decoder
    def decode_uint(value, subtype = "256", start = 0) # ex: 0x4563918244f40000 => 5000000000000000000 (5 KLAY)
      trim(value, start, bitsize(subtype)).hex
    end

    def trim(value, start, bitsize = 256)
      value[start+63-(bitsize/4-1)..start+63]
    end

    def bitsize(subtype, default = 256)
      subtype.present? ? subtype.to_i : default
    end
  end
end

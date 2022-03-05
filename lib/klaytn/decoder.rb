module Klaytn
  class Decoder
    def decode_uint(value, subtype = "256", start = 0)
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

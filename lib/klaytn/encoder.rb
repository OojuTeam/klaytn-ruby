module Klaytn
  class Encoder
    def encode_function(definition, inputs, params)
      prefix = '0x'
      str = Digest::Keccak.hexdigest(definition, 256)[0..7] # ex: "getEarnout(uint256)"
      num = encode_arguments(inputs, params)

      "#{prefix}#{str}#{num}"
    end

    def encode_integer(integer) # ex: 5000000000000000000 (5 KLAY) => 0x4563918244f40000
      return '0x0' if integer.zero?
      long = encode_uint(integer)
      '0x' + long.sub!(/^[0]+/,'')
    end

    # code below this point was adopted from ethereum.rb gem in order to
    # avoid dependency issues with Digest requiring older Ruby versions
    def encode(type, value)
      is_array, arity, array_subtype = parse_array_type(type)
      if is_array && arity
        encode_static_array(arity, array_subtype, value)
      elsif is_array
        encode_dynamic_array(array_subtype, value)
      else
        core, subtype = parse_type(type)
        method_name = "encode_#{core}".to_sym
        self.send(method_name, value, subtype)
      end
    end

    def encode_static_array(arity, array_subtype, array)
      raise "Wrong number of arguments" if arity != array.size
      array.inject("") { |a, e| a << encode(array_subtype, e) }
    end

    def encode_dynamic_array(array_subtype, array)
      location = encode_uint(@inputs ? size_of_inputs(@inputs) + @tail.size/2 : 32)
      size = encode_uint(array.size)
      data = array.inject("") { |a, e| a << encode(array_subtype, e) }
      [location, size + data]
    end

    def parse_array_type(type)
      match = /(.+)\[(\d*)\]\z/.match(type)
      if match
        [true, match[2].present? ? match[2].to_i : nil, match[1]]
      else
        [false, nil, nil]
      end
    end

    def parse_type(type)
      puts "TYPE: #{type}"
      # raise NotImplementedError if type.ends_with?("]")
      raise NotImplementedError if type[-1] == "]"
      match = /(\D+)(\d.*)?/.match(type)
      [match[1], match[2]]
    end

    def encode_arguments(inputs, args)
      raise "Wrong number of arguments" if inputs.length != args.length
      @head = ""
      @tail = ""
      @inputs = inputs
      inputs.each.with_index do |input, index|
        encoded = encode(input.type, args[index])
        if encoded.is_a? Array
          @head << encoded[0]
          @tail << encoded[1]
        else
          @head << encoded
        end
      end
      @head + @tail
    end

    def encode_bool(value, _)
      (value ? "1" : "0").rjust(64, '0')
    end

    def encode_fixed(value, subtype)
      n = subtype.nil? ? 128 : /(\d+)x(\d+)/.match(subtype)[2].to_i
      do_encode_fixed(value, n)
    end

    def do_encode_fixed(value, n)
      encode_uint((value * 2**n).to_i)
    end

    def encode_ufixed(_value, _)
      raise NotImplementedError
    end

    def encode_bytes(value, subtype)
      subtype.nil? ? encode_dynamic_bytes(value) : encode_static_bytes(value)
    end

    def encode_static_bytes(value)
      value.bytes.map {|x| x.to_s(16).rjust(2, '0')}.join("").ljust(64, '0')
    end

    def encode_dynamic_bytes(value)
      location = encode_uint(@inputs ? size_of_inputs(@inputs) + @tail.size/2 : 32)
      size = encode_uint(value.size)
      content = encode_static_bytes(value)
      [location, size + content]
    end

    def encode_string(value, _)
      location = encode_uint(@inputs ? size_of_inputs(@inputs) + @tail.size/2 : 32)
      size = encode_uint(value.bytes.size)
      content = value.bytes.map {|x| x.to_s(16).rjust(2, '0')}.join("").ljust(64, '0')
      [location, size + content]
    end

    def encode_address(value, _)
      value = "0" * 24 + value.gsub(/^0x/,'')
      raise ArgumentError if value.size != 64
      value
    end

    def encode_uint(value, _ = nil)
      raise ArgumentError if value < 0
      encode_int(value)
    end

    def encode_int(value, _ = nil)
      to_twos_complement(value).to_s(16).rjust(64, '0')
    end

    def to_twos_complement(number)
      (number & ((1 << 256) - 1))
    end
  end
end

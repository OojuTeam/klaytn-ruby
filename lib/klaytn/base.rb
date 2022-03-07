module Klaytn
  class Base
    INVALID_CLIENT = 'No params provided - please provide a contract address, ABI, KAS credentials, etc'.freeze
    MISSING_KAS_CREDS = 'KAS credentials missing'.freeze
    MISSING_CONTRACT = 'Please provide a deployed smart contract address.'.freeze

    MISSING_ACCOUNT_WALLET = 'Please provide a KAS Account wallet to pay for transactions.'.freeze # created via KAS > Service > Wallet > Account Pool > Create Account Pool > Create Account
    MISSING_ACCOUNT_POOL_KRN = 'Please provide a KAS Account Pool KRN id to finish linking your KAS Wallet (ex: krn:XXXX:wallet:yyyy...).'.freeze # KAS > Service > Wallet > Account Pool > KRN
    MISSING_ABI = 'Please provide the contract ABI, an array-like object returned by the compiler.'.freeze
    FUNCTION_NOT_FOUND = 'Function with definition XXX not found.'.freeze
    MISSING_JSONRPC_METHOD = 'RPC method name required, e.g. klay_blockNumber.'.freeze
  end
end

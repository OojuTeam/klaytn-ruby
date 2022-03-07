RSpec.shared_examples 'contract_stubs', contract_stubs: true do
  let(:invalid_client) {
    Klaytn::Contract.new(kas_access_key: ENV['KAS_ACCESS_KEY'], kas_secret_access_key: ENV['KAS_SECRET_ACCESS_KEY'])
  }

  let(:client) {
    Klaytn::Contract.new(kas_account_wallet_address: ENV['KAS_ACCOUNT_WALLET_ADDRESS'], kas_account_pool_krn: ENV['KAS_ACCOUNT_POOL_KRN'], kas_access_key: ENV['KAS_ACCESS_KEY'], kas_secret_access_key: ENV['KAS_SECRET_ACCESS_KEY'])
  }

  let(:interactive_client) {
    Klaytn::Contract.new(abi: abi, contract_address: deployed_contract_address, kas_account_wallet_address: ENV['KAS_ACCOUNT_WALLET_ADDRESS'], kas_account_pool_krn: ENV['KAS_ACCOUNT_POOL_KRN'], kas_access_key: ENV['KAS_ACCESS_KEY'], kas_secret_access_key: ENV['KAS_SECRET_ACCESS_KEY'])
  }

  let(:bytecode) {
    "0x60c0604052601060808190526f48656c6c6f2066726f6d204f6f6a752160801b60a09081526100319160009190610044565b5034801561003e57600080fd5b50610118565b828054610050906100dd565b90600052602060002090601f01602090048101928261007257600085556100b8565b82601f1061008b57805160ff19168380011785556100b8565b828001600101855582156100b8579182015b828111156100b857825182559160200191906001019061009d565b506100c49291506100c8565b5090565b5b808211156100c457600081556001016100c9565b6002810460018216806100f157607f821691505b6020821081141561011257634e487b7160e01b600052602260045260246000fd5b50919050565b610276806101276000396000f3fe608060405234801561001057600080fd5b50600436106100415760003560e01c80637b9417c8146100465780639b19251a1461006e578063cfae321714610091575b600080fd5b610059610054366004610184565b6100a6565b60405190151581526020015b60405180910390f35b61005961007c366004610184565b60016020526000908152604090205460ff1681565b6100996100f2565b60405161006591906101b2565b6001600160a01b03811660009081526001602052604081205460ff166100ed57506001600160a01b0381166000908152600160208190526040909120805460ff1916821790555b919050565b60606000805461010190610205565b80601f016020809104026020016040519081016040528092919081815260200182805461012d90610205565b801561017a5780601f1061014f5761010080835404028352916020019161017a565b820191906000526020600020905b81548152906001019060200180831161015d57829003601f168201915b5050505050905090565b600060208284031215610195578081fd5b81356001600160a01b03811681146101ab578182fd5b9392505050565b6000602080835283518082850152825b818110156101de578581018301518582016040015282016101c2565b818111156101ef5783604083870101525b50601f01601f1916929092016040019392505050565b60028104600182168061021957607f821691505b6020821081141561023a57634e487b7160e01b600052602260045260246000fd5b5091905056fea2646970667358221220f4bfbe8cb7e83e2dc08a85cb0aef9715cf093c936671fdb93f966a57830c4a5464736f6c63430008020033"
  }

  let(:deployed_contract_response) {
    {"from"=>"0x6e1f42c1eb314a0f53ca6ae836be077aaeee6cc0", "gas"=>9000000, "gasPrice"=>"0xae9f7bcc00", "input"=>bytecode, "nonce"=>24, "rlp"=>"0x28f9040d1885ae9f7bcc00838954408080946e1f42c1eb314a0f53ca6ae836be077aaeee6cc0b9039d60c0604052601060808190526f48656c6c6f2066726f6d204f6f6a752160801b60a09081526100319160009190610044565b5034801561003e57600080fd5b50610118565b828054610050906100dd565b90600052602060002090601f01602090048101928261007257600085556100b8565b82601f1061008b57805160ff19168380011785556100b8565b828001600101855582156100b8579182015b828111156100b857825182559160200191906001019061009d565b506100c49291506100c8565b5090565b5b808211156100c457600081556001016100c9565b6002810460018216806100f157607f821691505b6020821081141561011257634e487b7160e01b600052602260045260246000fd5b50919050565b610276806101276000396000f3fe608060405234801561001057600080fd5b50600436106100415760003560e01c80637b9417c8146100465780639b19251a1461006e578063cfae321714610091575b600080fd5b610059610054366004610184565b6100a6565b60405190151581526020015b60405180910390f35b61005961007c366004610184565b60016020526000908152604090205460ff1681565b6100996100f2565b60405161006591906101b2565b6001600160a01b03811660009081526001602052604081205460ff166100ed57506001600160a01b0381166000908152600160208190526040909120805460ff1916821790555b919050565b60606000805461010190610205565b80601f016020809104026020016040519081016040528092919081815260200182805461012d90610205565b801561017a5780601f1061014f5761010080835404028352916020019161017a565b820191906000526020600020905b81548152906001019060200180831161015d57829003601f168201915b5050505050905090565b600060208284031215610195578081fd5b81356001600160a01b03811681146101ab578182fd5b9392505050565b6000602080835283518082850152825b818110156101de578581018301518582016040015282016101c2565b818111156101ef5783604083870101525b50601f01601f1916929092016040019392505050565b60028104600182168061021957607f821691505b6020821081141561023a57634e487b7160e01b600052602260045260246000fd5b5091905056fea2646970667358221220f4bfbe8cb7e83e2dc08a85cb0aef9715cf093c936671fdb93f966a57830c4a5464736f6c634300080200338080f847f8458207f6a028b8cfef2e4c7d6af8686040eeabaae2ce1b3ccfe03adfeef0dba5b021693bbca059da534ae2d58fc30645e81dd914a09bb01bdd9d7aea0cd5cc643ded96143245", "signatures"=>[{"R"=>"0x28b8cfef2e4c7d6af8686040eeabaae2ce1b3ccfe03adfeef0dba5b021693bbc", "S"=>"0x59da534ae2d58fc30645e81dd914a09bb01bdd9d7aea0cd5cc643ded96143245", "V"=>"0x7f6"}], "typeInt"=>40, "value"=>"0x0"}
  }

  let(:abi) {
    [{:inputs=>[{:internalType=>"address", :name=>"addr", :type=>"address"}], :name=>"addAddressToWhitelist", :outputs=>[{:internalType=>"bool", :name=>"success", :type=>"bool"}], :stateMutability=>"nonpayable", :type=>"function"}, {:inputs=>[], :name=>"greet", :outputs=>[{:internalType=>"string", :name=>"", :type=>"string"}], :stateMutability=>"view", :type=>"function"}, {:inputs=>[{:internalType=>"address", :name=>"", :type=>"address"}], :name=>"whitelist", :outputs=>[{:internalType=>"bool", :name=>"", :type=>"bool"}], :stateMutability=>"view", :type=>"function"}]
  }

  let(:deployed_contract_address) { '0x2a9b4e12ed1034cc542111cffdfae47d316331bc' }

  let(:address_to_whitelist) { '0x00E7b604e9493d53749e7b7b9e39F313d9F9890a' }

  let(:invoke_function_response) {
    {"from"=>"0x3f71cde4246cbc89ec41c2753aec05f8358e0782", "gas"=>1000000, "gasPrice"=>"0xae9f7bcc00", "input"=>"0x7b9417c800000000000000000000000000e7b604e9493d53749e7b7b9e39f313d9f9890a", "nonce"=>11, "rlp"=>"0x30f8a40b85ae9f7bcc00830f4240942a9b4e12ed1034cc542111cffdfae47d316331bc80943f71cde4246cbc89ec41c2753aec05f8358e0782a47b9417c800000000000000000000000000e7b604e9493d53749e7b7b9e39f313d9f9890af847f8458207f6a0fed2711b2cb9198c537c8e8966d5148a31469922f9bfa6f7634d6a705ef07c4da0165eee6b6083f93904521e65b3abb1e51b221f36353266c99cf527f906ce001f", "signatures"=>[{"R"=>"0xfed2711b2cb9198c537c8e8966d5148a31469922f9bfa6f7634d6a705ef07c4d", "S"=>"0x165eee6b6083f93904521e65b3abb1e51b221f36353266c99cf527f906ce001f", "V"=>"0x7f6"}], "status"=>"Submitted", "to"=>deployed_contract_address, "transactionHash"=>"0xae4e43c73d9b7ddffb29253a5bf7094331fcc7f7f5232b4df25424f870ca9595", "typeInt"=>48, "value"=>"0x0"}
  }

  # sample contract used to create test case 'bytecode' (compiled via hardhat) and 'Klaytn::Contract.invoke_function' arguments
  # // SPDX-License-Identifier: MIT
  # pragma solidity ^0.8.2;
  #
  # contract KlaytnGreeter {
  #     /* Define variable greeting of the type string */
  #     string greeting = "Hello from Ooju!";
  #     mapping(address => bool) public whitelist;
  #
  #     /* View */
  #     function greet() public view returns (string memory) {
  #         return greeting;
  #     }
  #
  #     /* Function */
  #     function addAddressToWhitelist(address addr) public returns(bool success) {
  #       if (!whitelist[addr]) {
  #         whitelist[addr] = true;
  #         success = true;
  #       }
  #     }
  # }
end

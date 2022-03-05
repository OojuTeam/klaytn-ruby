RSpec.describe Klaytn do
  context 'gem installation' do
    it "has a version number" do
      expect(Klaytn::VERSION).not_to be nil
    end

    it "has necessary dependencies" do
      expect(HTTParty::VERSION).not_to be nil
      expect(Ethereum::VERSION).not_to be nil
    end
  end

  context 'client instantiation' do
    it "does now allow empty instantiation" do
      expect {
        Klaytn::Client.new
      }.to raise_error(RuntimeError).with_message(Klaytn::Base::INVALID_CLIENT)
    end

    it "does now allow instantiation without KAS credentials" do
      expect {
        Klaytn::Client.new({chain_id: 1001})
      }.to raise_error(RuntimeError).with_message(Klaytn::Base::MISSING_KAS_CREDS)
    end
  end

  context 'Klaytn::Transaction', transaction_stubs: true do
    it "defaults to testnet" do
      expect(client.chain_id).to eql(1001)
    end

    it "fetches a transaction" do
      result = client.get(get_transaction_hash)
      expect(result['blockHash']).to eql(get_transaction_response['blockHash'])
    end

    it "sends a transaction for 1 PEB" do
      result = client.send(send_transaction_recipient, 1, { memo: 'test', submit: false })
      expect(result['value']).to eql('0x1') # 1 peb
      expect(result['input']).to eql('0x74657374') # encoding of string 'test' in memo field
    end
  end

  context 'Klaytn::Wallet', wallet_stubs: true do
    it "fetches a wallet" do
      result = client.get(wallet_address)
      expect(result['result']['address']).to eql(wallet_address)
      expect(result['result']['txCount']).to be >= 52
    end

    it "fetches a wallet's raw PEB balance" do
      result = client.get(wallet_address)
      expect(result['result']['balance']).to_not be nil
    end

    it "converts a wallet's raw PEB balance to friendly KLAY value" do
      raw_balance_result = client.get(wallet_address)['result']['balance'].to_f
      friendly_balance_result = client.get_balance(wallet_address)

      # skip test if wallet is empty
      if raw_balance_result > 0
        expect(friendly_balance_result * Klaytn::Wallet::PEB_DIVISOR).to eql(raw_balance_result)
      end
    end

    it "allows disabling wallet balance PEB conversion" do
      disabled_client = Klaytn::Wallet.new(peb_divisor: false)
      raw_balance_result = disabled_client.get(wallet_address)['result']['balance'].to_f
      friendly_balance_result = disabled_client.get_balance(wallet_address)

      expect(friendly_balance_result).to eql(raw_balance_result)
    end
  end

  context 'Klaytn::Token', token_stubs: true do
    it "does not allow instantiation without a smart contract address" do
      expect {
        invalid_client
      }.to raise_error(RuntimeError).with_message(Klaytn::Base::MISSING_CONTRACT)
    end

    it "fetches a token" do
      result = client.get(token_id)
      expect(result['tokenId']).to eql '0x1'
      expect(result['transactionHash']).to eql get_token_response['transactionHash']
    end
  end

  context 'Klaytn::Contract', contract_stubs: true do
    it "does not allow instantiation without a smart contract address" do
      expect {
        invalid_client
      }.to raise_error(RuntimeError).with_message(Klaytn::Base::MISSING_ACCOUNT_WALLET)
    end

    it "deploys a contract" do
      result = client.deploy(bytecode, submit: false) # avoid unncessary gas fees
      expect(result['input']).to eql bytecode
      expect(result['value']).to eql '0x0'
    end

    it "does not find function in contract" do
      invalid_function = 'removeAddressFromWhitelist'
      custom_error_msg = Klaytn::Base::FUNCTION_NOT_FOUND.gsub('XXX', invalid_function)

      expect {
        interactive_client.invoke_function(invalid_function, [address_to_whitelist])
      }.to raise_error(RuntimeError).with_message(custom_error_msg)
    end

    # NOTE: if you run the test suite back to back, this can fail due to the previous tx not completing (same nonce):
    # {"code"=>1065001, "message"=>"failed to send a raw transaction to klaytn node; there is another tx which has the same nonce in the tx pool", "requestId"=>"29c8f0da-eaf9-4cec-9b0a-332396b669e9"}
    it "interacts with contract" do
      result = interactive_client.invoke_function('addAddressToWhitelist', [address_to_whitelist])

      if result['message'].include?('there is another tx which has the same nonce')
        puts "'interacts with contract' example not run -- still awaiting previous transaction completion"
      else
        expect(result['to']).to eql(deployed_contract_address)
      end
    end
  end
end

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
      }.to raise_error(RuntimeError).with_message(Klaytn::Client::INVALID_CLIENT_MSG)
    end

    it "does now allow instantiation without KAS credentials" do
      expect {
        Klaytn::Client.new({chain_id: 1001})
      }.to raise_error(RuntimeError).with_message(Klaytn::Client::MISSING_KAS_MSG)
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

    it "cannot send a transaction for 0 KLAY tokens" do
      result = client.send(send_transaction_recipient, 0)
      expect(result['message']).to eql(send_empty_transaction_response['message'])
    end

    it "sends a transaction for 1 PEB" do
      paying_client = Klaytn::Transaction.new(kas_account_wallet_address: ENV['KAS_ACCOUNT_WALLET_ADDRESS'], kas_access_key: ENV['KAS_ACCESS_KEY'], kas_secret_access_key: ENV['KAS_SECRET_ACCESS_KEY'])
      result = paying_client.send(send_transaction_recipient, 1, { memo: 'test', submit: false })
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
      }.to raise_error(RuntimeError).with_message(Klaytn::Token::MISSING_CONTRACT_MSG)
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
      }.to raise_error(RuntimeError).with_message(Klaytn::Contract::MISSING_ACCOUNT_WALLET_MSG)
    end

    it "deploys a contract" do
      result = client.deploy(bytecode, submit: false) # avoid unncessary gas fees
      expect(result['input']).to eql bytecode
      expect(result['value']).to eql '0x0'
    end
  end
end

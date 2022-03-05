RSpec.shared_examples 'wallet_stubs', wallet_stubs: true do
  let(:client) { Klaytn::Wallet.new }

  let(:wallet_address) { '0x00e7b604e9493d53749e7b7b9e39f313d9f9890a' }

  let(:get_wallet_response) {
    {
      "success"=>true, "code"=>0, "result"=>{ "address"=>"0x00e7b604e9493d53749e7b7b9e39f313d9f9890a", "balance"=>"306619995824101323564", "type"=>0, "transferCount"=>1, "nftTransferCount"=>1, "txCount"=>52, "eventCount"=>0, "internalTxCount"=>34, "feePaid"=>false }
    }
  }
end

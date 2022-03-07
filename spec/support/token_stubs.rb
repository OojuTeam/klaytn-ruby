RSpec.shared_examples 'token_stubs', token_stubs: true do
  let(:invalid_client) {
    Klaytn::Token.new
  }

  let(:client) {
    Klaytn::Token.new(contract_address: contract_address, kas_access_key: ENV['KAS_ACCESS_KEY'], kas_secret_access_key: ENV['KAS_SECRET_ACCESS_KEY'])
  }

  let(:contract_address) { '0xbceaa2fa50fef79bb5c4b2fc887dbdd3b96130b7' }

  let(:token_id) { 1 }

  let(:get_token_response) {
    {"tokenId"=>"0x1", "owner"=>"0x58e0cc862c13249cbfad5b47f10a0f456cda1470", "previousOwner"=>"0x0000000000000000000000000000000000000000", "tokenUri"=>"https://gateway.pinata.cloud/ipfs/QmVgQbqr9DSJSUDrwfzxqGnHG8sMKcgDc9uo2n1HEXKHau/1", "transactionHash"=>"0x7f0e09d9277ef23e4dd3651ce5d9a0ec7613a5f1eec336ed37743421cc1f0d61", "createdAt"=>1642819360, "updatedAt"=>1642819360}
  }
end

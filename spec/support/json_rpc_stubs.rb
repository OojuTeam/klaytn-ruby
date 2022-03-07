RSpec.shared_examples 'json_rpc_stubs', json_rpc_stubs: true do
  let(:client) {
    Klaytn::JsonRpc.new(kas_access_key: ENV['KAS_ACCESS_KEY'], kas_secret_access_key: ENV['KAS_SECRET_ACCESS_KEY'])
  }

  let(:is_contract_params) {
    { method: 'klay_isContractAccount', params: ["0xbceaa2fa50fef79bb5c4b2fc887dbdd3b96130b7", "latest"] }
  }

  let(:is_not_contract_params) {
    { method: 'klay_isContractAccount', params: ["0x58E0cc862c13249CBFAD5B47F10A0F456cDA1470", "latest"] }
  }

  let(:is_contract_response) {
    { "jsonrpc"=>"2.0", "id"=>1, "result"=>true }
  }

  let(:is_not_contract_response) {
    { "jsonrpc"=>"2.0", "id"=>1, "result"=>false }
  }
end

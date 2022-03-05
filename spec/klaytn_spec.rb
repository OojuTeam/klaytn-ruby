RSpec.describe Klaytn do
  it "has a version number" do
    expect(Klaytn::VERSION).not_to be nil
  end

  it "does now allow empty instantiation" do
    expect {
      Klaytn::Client.new
    }.to raise_error(RuntimeError).with_message('No params provided - please provide a contract address, ABI, KAS credentials, etc')
  end
end

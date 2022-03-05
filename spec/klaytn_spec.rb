RSpec.describe Klaytn do
  it "has a version number" do
    expect(Klaytn::VERSION).not_to be nil
  end

  it "has necessary dependencies" do
    expect(HTTParty::VERSION).not_to be nil
    expect(Ethereum::VERSION).not_to be nil
  end

  it "does now allow empty instantiation" do
    expect {
      Klaytn::Client.new
    }.to raise_error(RuntimeError).with_message(Klaytn::Client::INVALID_CLIENT_MSG)
  end
end

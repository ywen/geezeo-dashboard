require 'spec_helper'

describe Account do
  describe ".fetch" do
    let(:account_hash1) { { attr1: "val1" } }
    let(:account_hash2) { { attr2: "val2" } }
    let(:account1) { double :account1 }
    let(:account2) { double :account2 }
    let(:account_array) { [ account_hash1, account_hash2 ] }

    before(:each) do
      Connector.stub(:get).with(:accounts).and_return account_array
    end

    it "fetches accounts" do
      Connector.should_receive(:get).with(:accounts).and_return []
      Account.fetch
    end

    it "returns the account array" do
      Account.should_receive(:new).with(account_hash1).and_return account1
      Account.should_receive(:new).with(account_hash2).and_return account2
      expect(Account.fetch).to eq([account1, account2])
    end
  end
end
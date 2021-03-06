require 'spec_helper'

describe Account do
  subject { described_class.new account_hash }

  describe ".fetch" do
    let(:account_hash1) { { attr1: "val1" } }
    let(:account_hash2) { { attr2: "val2" } }
    let(:account1) { double :account1 }
    let(:account2) { double :account2 }
    let(:account_array) { [ account_hash1, account_hash2 ] }

    before(:each) do
      Connector.stub(:get).with(:accounts).and_return account_array
      Account::Persistence.stub(:save)
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

    it "saves accounts" do
      Account::Persistence.should_receive(:save)
      Account.fetch
    end
  end

  describe "#name" do
    let(:account_hash) { { name: "name" } }

    it "returns the balance in cents" do
      expect(subject.name).to eq("name")
    end
  end
end

describe Account::Persistence do
  let(:account2) { double :account2, id: 14, name: "name2" }
  let(:account1) { double :account1, id: 12, name: "name1" }

  describe ".save" do
    let(:results) { YAML.load_file("#{Rails.root}/db/accounts.yml") }

    it "writes to YAML with id and name" do
      described_class.save([account1, account2])
      expect(results).to eq( 12 => "name1", 14 => "name2" )
    end
  end

  describe ".load" do
    let(:results) { described_class.load }

    it "writes to YAML with id and name" do
      described_class.save([account1, account2])
      expect(results).to eq( 12 => "name1", 14 => "name2" )
    end
  end
end

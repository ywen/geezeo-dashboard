require 'spec_helper'

describe Transaction do
  describe ".fetch" do
    let(:transaction_hash1) { { attr1: "val1" } }
    let(:transaction_hash2) { { attr2: "val2" } }
    let(:transaction1) { double :transaction1 }
    let(:transaction2) { double :transaction2 }
    let(:transaction_array) { [ transaction_hash1, transaction_hash2 ] }
    let(:params) { { account_id: "12" } }

    before(:each) do
      Connector.stub(:get).and_return transaction_array
    end

    it "fetches transactions" do
      Connector.should_receive(:get).with(:transactions, '12').and_return []
      Transaction.fetch(params)
    end

    it "returns the transaction array" do
      Transaction.should_receive(:new).with(transaction_hash1).and_return transaction1
      Transaction.should_receive(:new).with(transaction_hash2).and_return transaction2
      expect(Transaction.fetch(params)).to eq([transaction1, transaction2])
    end
  end
end

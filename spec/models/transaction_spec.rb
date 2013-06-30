require 'spec_helper'

describe TransactionsList do
  describe ".fetch" do
    let(:transaction_hash1) { { attr1: "val1" } }
    let(:transaction_hash2) { { attr2: "val2" } }
    let(:transaction1) { double :transaction1 }
    let(:transaction2) { double :transaction2 }
    let(:transaction_array) { [ transaction_hash1, transaction_hash2 ] }
    let(:params) { { account_id: "12" } }
    let(:connector_transaction) {
      double :connector_transaction, transactions_array: [transaction_hash1, transaction_hash2]
    }

    before(:each) do
      Connector.stub(:get).and_return connector_transaction
    end

    it "fetches transactions" do
      Connector.should_receive(:get).with(:transactions, '12').and_return connector_transaction
      described_class.fetch(params)
    end

    it "returns the TransactionsList object" do
      expect(described_class.fetch(params)).to be_a(TransactionsList)
    end
  end
end

require 'spec_helper'

describe TransactionsList do
  describe ".fetch" do
    let(:transaction_hash1) { { transaction: { attr1: "val1" } } }
    let(:transaction_hash2) { { transaction: { attr2: "val2" } } }
    let(:transaction1) { double :transaction1 }
    let(:transaction2) { double :transaction2 }
    let(:transaction_array) { [ transaction_hash1, transaction_hash2 ] }
    let(:params) { { account_ids: "12,14" } }
    let(:connector_transaction1) {
      double :connector_transaction1, transactions_array: [transaction_hash1, transaction_hash2]
    }
    let(:connector_transaction2) {
      double :connector_transaction2, transactions_array: []
    }

    before(:each) do
      Connector.stub(:get).with(:transactions, '12').and_return connector_transaction1
      Connector.stub(:get).with(:transactions, '14').and_return connector_transaction2
    end

    it "fetches transactions" do
      Connector.should_receive(:get).with(:transactions, '12').and_return connector_transaction1
      Connector.should_receive(:get).with(:transactions, '14').and_return connector_transaction2
      described_class.fetch(params)
    end

    it "returns the TransactionsList object" do
      expect(described_class.fetch(params)).to be_a(TransactionsList)
    end
  end
end

describe Transaction do
  subject { described_class.new response_hash }

  describe "#debit?" do
    context "when the Transaction type is debit" do
      let(:response_hash) { { transaction_type: "Debit" } }

      it "is debit" do
        expect(subject).to be_debit
      end
    end

    context "when the Transaction type is not debit" do
      let(:response_hash) { { transaction_type: "Credit" } }

      it "is not debit" do
        expect(subject).not_to be_debit
      end
    end
  end

  describe "#posted_at" do
    let(:time) { "2013-06-19T15:53:53+00:00" }
    let(:response_hash) { { posted_at: time } }

    it "returns a time" do
      expect(subject.posted_at).to eq(time.to_time)
    end
  end
end

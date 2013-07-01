require 'spec_helper'

describe TransactionList do
  subject { described_class.new transaction_array, transaction_list_data }

  let(:transaction_array) { [] }
  let(:transaction_list_data) { [] }

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
      Account::Persistence.stub(:load).and_return({ 12 => "name1", 14 => "name2" })
    end

    it "fetches transactions" do
      Connector.should_receive(:get).with(:transactions, '12').and_return connector_transaction1
      Connector.should_receive(:get).with(:transactions, '14').and_return connector_transaction2
      described_class.fetch(params)
    end

    it "returns the TransactionList object" do
      expect(described_class.fetch(params)).to be_a(TransactionList)
    end
  end

  describe "#has_next_page?" do
    let(:transaction_list_data) { [ data1, data2 ] }
    let(:data1) { double :data1, has_next_page?: false }
    let(:data2) { double :data2, has_next_page?: false }

    context "when the transaction list data is empty" do
      let(:transaction_list_data) { [] }

      it "has no next page" do
        expect(subject).not_to have_next_page
      end
    end

    context "when all data has no next page" do
      it "has no next page" do
        expect(subject).not_to have_next_page
      end
    end

    context "when one data has next page" do
      it "has next page" do
        data2.stub(:has_next_page?).and_return true
        expect(subject).to have_next_page
      end
    end
  end

  describe "#next_page" do
    let(:transaction_list_data) { [ data1, data2 ] }
    let(:data1) { double :data1, next_page: 2 }
    let(:data2) { double :data2, next_page: 2 }

    it "returns the first data's next page" do
      expect(subject.next_page).to eq(2)
    end

    context "when no data" do
      let(:transaction_list_data) { [] }

      it "returns 1" do
        expect(subject.next_page).to eq(1)
      end
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

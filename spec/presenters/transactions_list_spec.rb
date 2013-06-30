require 'spec_helper'

module Presenters
  describe TransactionsList do
    subject { described_class.new model }

    let(:transaction1) { double :transaction1 }
    let(:transaction2) { double :transaction2 }
    let(:model) { double :model, transactions: [transaction1, transaction2] }

    describe "#each_transaction" do
      it "loops through transaction, wraps into presenter" do
        transactions = []
        subject.each_transaction {|t| transactions << t }
        models = transactions.map {|t| t.send(:model) }
        expect(models).to eq([transaction1, transaction2])
      end
    end
  end
end

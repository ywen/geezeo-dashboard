require 'spec_helper'

module Presenters
  describe Transaction do
    subject { described_class.new model}

    let(:model) { double :model, balance: 12345, debit?: true }

    describe "#formatted_balance" do
      context "when the transaction is a debit transaction" do
        it "returns minus format" do
          expect(subject.formatted_balance).to eq("$ -123.45")
        end
      end

      context "when the transaction is a credit transaction" do
        before(:each) do
          model.stub(:debit?).and_return false
        end

        it "returns positive format" do
          expect(subject.formatted_balance).to eq("$ 123.45")
        end
      end
    end
  end
end

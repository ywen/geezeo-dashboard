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

    describe "#tags" do
      let(:tags) { [
        {tag: {name: "Personal", balance: 200.0}},
        {tag: { name: "Tag2", balanceL: 222 }}
      ] }

      before(:each) do
        model.stub(:tags).and_return tags
      end

      it "returns tag names" do
        expect(subject.tags).to eq("Personal, Tag2")
      end
    end

    describe "#posted_at_str" do
      let(:time) { "2013-09-08 13:15".to_time }

      before(:each) do
        model.stub(:posted_at).and_return time
      end

      it "returns the time formatted" do
        expect(subject.posted_at_str).to eq("09/08/2013 01:15 PM")
      end
    end

    describe "#balance_class" do
      context "when the transaction is a debit" do
        it "returns debit" do
          expect(subject.balance_class).to eq("debit")
        end
      end

      context "when the transaction is a credit" do
        it "returns credit" do
          model.stub(:debit?).and_return false
          expect(subject.balance_class).to eq("credit")
        end
      end
    end
  end
end

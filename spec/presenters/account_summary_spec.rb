require 'spec_helper'

module Presenters
  describe AccountSummary do
    subject { described_class.new [presenter1, presenter2] }

    let(:model1) { double :model1 }
    let(:model2) { double :model2 }
    let(:presenter1) { double :presenter1 }
    let(:presenter2) { double :presenter2 }

    describe ".build" do
      let(:result) { AccountSummary.build([model1, model2]) }

      it "builds an AccountSummary object" do
        expect(result).to be_a(AccountSummary)
      end

      it "set a presenter version of Account" do
        Account.should_receive(:new).with(model1).and_return presenter1
        Account.should_receive(:new).with(model2).and_return presenter2
        AccountSummary.should_receive(:new).with([presenter1, presenter2])
        result
      end
    end

    describe "#each_account" do
      it "loops through the accounts and yield" do
        accounts = []
        subject.each_account {|account| accounts << account }
        expect(accounts).to eq([presenter1, presenter2])
      end
    end

    describe "#formatted_balance" do
      before(:each) do
        presenter1.stub(:balance).and_return 23467
        presenter2.stub(:balance).and_return 46789
      end

      it "returns the sum of the balance with formatting" do
        expect(subject.formatted_balance).to eq("$ 702.56")
      end
    end
  end
end

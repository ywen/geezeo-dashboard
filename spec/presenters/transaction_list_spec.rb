require 'spec_helper'

module Presenters
  describe TransactionList do
    subject { described_class.new model }

    let(:transaction1) { double :transaction1, posted_at: 3.days.ago }
    let(:transaction2) { double :transaction2, posted_at: 2.days.ago }
    let(:model) { double :model, transactions: [transaction1, transaction2] }

    forward_from_model_attributes :has_next_page?, :next_page

    describe "#each_transaction" do
      it "loops through transaction, sort by posted_at, wraps into presenter" do
        transactions = []
        subject.each_transaction {|t| transactions << t }
        models = transactions.map {|t| t.send(:model) }
        expect(models).to eq([transaction2, transaction1])
      end
    end

    describe "#loading_full_page?" do
      context "when the next page is 2" do
        before(:each) do
          model.stub(:next_page).and_return 2
        end

        it "loads the full page" do
          expect(subject).to be_loading_full_page
        end
      end

      context "when the next page is bigger than 2" do
        before(:each) do
          model.stub(:next_page).and_return 3
        end

        it "does not load the full page" do
          expect(subject).not_to be_loading_full_page
        end
      end
    end
  end
end

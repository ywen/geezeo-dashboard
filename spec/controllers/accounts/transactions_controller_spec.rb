require 'spec_helper'

describe Accounts::TransactionsController do
  describe "GET#index" do
    let(:transaction1) { double :transaction1 }
    let(:transaction2) { double :transaction2 }
    let(:presenter1) { double :presenter1 }
    let(:presenter2) { double :presenter2 }

    before(:each) do
      Transaction.stub(:fetch).and_return([transaction1, transaction2])
    end

    it "fetches the transactions" do
      Transaction.should_receive(:fetch).and_return([transaction1, transaction2])
      get :index, account_id: "12"
    end

    it "builds the presenters" do
      Presenters::Transaction.should_receive(:new).with(transaction1).and_return presenter1
      Presenters::Transaction.should_receive(:new).with(transaction2).and_return presenter2
      get :index, account_id: "12"
    end

    it "builds the presenters" do
      Presenters::Transaction.stub(:new).with(transaction1).and_return presenter1
      Presenters::Transaction.stub(:new).with(transaction2).and_return presenter2
      get :index, account_id: "12"
      expect(assigns[:presenters]).to eq([presenter1, presenter2])
    end
  end
end

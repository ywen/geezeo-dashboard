require 'spec_helper'

describe Accounts::TransactionsController do
  describe "GET#index" do
    let(:transaction_list) { double :transaction_list }
    let(:presenter) { double :presenter }

    before(:each) do
      TransactionsList.stub(:fetch).and_return(transaction_list)
    end

    it "fetches the transactions" do
      TransactionsList.should_receive(:fetch).and_return(transaction_list)
      get :index, account_id: "12"
    end

    it "builds the presenters" do
      Presenters::TransactionsList.should_receive(:new).with(transaction_list).and_return presenter
      get :index, account_id: "12"
    end

    it "assigns the presenters" do
      Presenters::TransactionsList.stub(:new).and_return presenter
      get :index, account_id: "12"
      expect(assigns[:presenter]).to eq(presenter)
    end
  end
end

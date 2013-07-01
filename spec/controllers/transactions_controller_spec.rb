require 'spec_helper'

describe TransactionsController do
  describe "GET#index" do
    let(:method_params) { { next_page: 12, has_next_page?: true } }
    let(:transaction_list) { double :transaction_list, method_params }
    let(:presenter) { double :presenter, method_params}

    before(:each) do
      TransactionList.stub(:fetch).and_return(transaction_list)
    end

    it "fetches the transactions" do
      TransactionList.should_receive(:fetch).and_return(transaction_list)
      get :index, account_id: "12"
    end

    it "builds the presenters" do
      Presenters::TransactionList.should_receive(:new).with(transaction_list).and_return presenter
      get :index, account_id: "12"
    end

    it "assigns the presenters" do
      Presenters::TransactionList.stub(:new).and_return presenter
      get :index, account_id: "12"
      expect(assigns[:presenter]).to eq(presenter)
    end
  end
end

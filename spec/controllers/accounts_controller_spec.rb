require 'spec_helper'

describe AccountsController do
  describe "GET#index" do
    let(:model1) { double :model1 }
    let(:model2) { double :model2 }
    let(:presenter) { double :presenter }

    before(:each) do
      Account.stub(:fetch).and_return [ model1, model2 ]
    end

    it "fetches the user information" do
      Account.should_receive(:fetch).and_return [ model1, model2 ]
      get :index
    end

    it "builds presenters from the models" do
      Presenters::AccountSummary.should_receive(:build).with([model1, model2]).and_return presenter
      get :index
    end

    it "assigns the presenter" do
      Presenters::AccountSummary.stub(:build).and_return presenter
      get :index
      expect(assigns[:presenter]).to eq(presenter)
    end
  end
end

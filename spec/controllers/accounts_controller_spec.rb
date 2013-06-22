require 'spec_helper'

describe AccountsController do
  describe "GET#index" do
    let(:model1) { double :model1 }
    let(:model2) { double :model2 }
    let(:presenter1) { double :presenter1 }
    let(:presenter2) { double :presenter2 }

    before(:each) do
      Account.stub(:fetch).and_return [ model1, model2 ]
    end

    it "fetches the user information" do
      Account.should_receive(:fetch).and_return [ model1, model2 ]
      get :index
    end

    it "initializes a statistics presenter" do
      Presenters::Account.should_receive(:new).with(model1).and_return presenter1
      Presenters::Account.should_receive(:new).with(model2).and_return presenter2
      get :index
    end

    it "assigns the presenter" do
      get :index
      expect(assigns[:presenters].size).to eq(2)
    end
  end
end

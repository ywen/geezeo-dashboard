require 'spec_helper'

describe UserStatisticsController do
  describe "GET#index" do
    let(:model) { double :model }
    let(:presenter) { double :presenter }

    before(:each) do
      Presenters::UserStatistics.stub(:new).and_return presenter
      Models::UserStatistics.stub(:fetch).and_return model
    end

    it "fetches the user information" do
      Models::UserStatistics.should_receive(:fetch).and_return model
      get :index
    end

    it "initializes a statistics presenter" do
      Presenters::UserStatistics.should_receive(:new).with(model).and_return presenter
      get :index
    end

    it "assigns the presenter" do
      get :index
      expect(assigns[:presenter]).to eq(presenter)
    end
  end
end

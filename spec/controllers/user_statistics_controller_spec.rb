require 'spec_helper'

describe UserStatisticsController do
  describe "GET#index" do
    let(:presenter) { double :presenter }

    before(:each) do
      Presenters::UserStatistics.stub(:new).and_return presenter
    end

    it "initializes a statistics presenter" do
      Presenters::UserStatistics.should_receive(:new).and_return presenter
      get :index
    end

    it "assigns the presenter" do
      get :index
      expect(assigns[:presenter]).to eq(presenter)
    end
  end
end

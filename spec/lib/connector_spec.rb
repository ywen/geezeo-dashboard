require 'spec_helper'

describe Connector do
  describe ".get" do
    let(:body) { { attr: "value" } }
    let(:response) { double :response, body: body.to_json }
    let(:connector) { double :connector, fetch: response }

    before(:each) do
      Connector::Account.stub(:new).and_return connector
    end

    it "gets the right kind of contents" do
      Connector::Account.should_receive(:new).and_return connector
      Connector.get :accounts
    end

    it "returns the result in hash" do
      expect(Connector.get(:accounts)).to eq(body)
    end

  end
end

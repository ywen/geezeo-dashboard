require 'spec_helper'

describe Connector do
  describe ".get" do
    let(:body) { { attr: "value" } }
    let(:response) { double :response, body: body.to_json }

    before(:each) do
      Connector::Account.stub(:fetch).and_return response
    end

    it "gets the right kind of contents" do
      Connector::Account.should_receive(:fetch).and_return response
      Connector.get :accounts
    end

    context "when extra params are passed in" do
      it "passes down to the actual connector" do
        Connector::Transaction.should_receive(:fetch).with(12).and_return response
        Connector.get :transactions, 12
      end
    end

    it "returns the result in hash" do
      expect(Connector.get(:accounts)).to eq(body)
    end

  end
end

module Connector
  describe Account do
    describe ".fetch" do
      it "asks the fetcher to fetch the results" do
        Fetcher.should_receive(:fetch)
        Account.fetch
      end
    end
  end

  describe Transaction do
    describe ".fetch" do
      let(:account_id) { 12 }

      it "asks the fetcher to fetch the results" do
        Fetcher.should_receive(:fetch).with("/12/transactions")
        Transaction.fetch(account_id)
      end
    end
  end

  describe Fetcher do
    describe ".fetch" do
      let(:credentials) { { "api_key" => "api_key", "user_id" => "user_id" } }

      before(:each) do
        HTTParty.stub(:get).and_return "response"
        YAML.stub(:load_file).and_return credentials
      end

      it "fetches result" do
        HTTParty.should_receive(:get).with(
          "https://api_key@beta-geezeosandbox.geezeo.com/api/v1/users/user_id/accounts"
        )
        Fetcher.fetch
      end

      it "returns the result" do
        expect(Fetcher.fetch).to eq("response")
      end

      context "with extra query string" do
        it "connects it" do
          HTTParty.should_receive(:get).with(
            "https://api_key@beta-geezeosandbox.geezeo.com/api/v1/users/user_id/accounts/extra"
          )
          Fetcher.fetch("/extra")
        end
      end
    end
  end
end

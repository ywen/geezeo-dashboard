require 'spec_helper'

describe Connector do
  let(:body) { { attr: "value" } }

  describe ".get" do

    before(:each) do
      Connector::Account.stub(:fetch).and_return body
    end

    it "gets the right kind of contents" do
      Connector::Account.should_receive(:fetch).and_return body
      Connector.get :accounts
    end

    context "when extra params are passed in" do
      it "passes down to the actual connector" do
        Connector::Transaction.should_receive(:fetch).with(12).and_return body
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
    let(:accounts_hash) { { accounts: [] } }

    describe ".fetch" do
      it "asks the fetcher to fetch the results" do
        Fetcher.should_receive(:fetch).and_return accounts_hash
        Account.fetch
      end
    end
  end

  describe Transaction do
    describe ".fetch" do
      let(:account_id) { 12 }
      let(:transactions_hash) { { transactions: [] } }

      it "asks the fetcher to fetch the results" do
        Fetcher.should_receive(:fetch).with("/12/transactions").and_return transactions_hash
        Transaction.fetch(account_id)
      end
    end
  end

  describe Fetcher do
    describe ".fetch" do
      let(:body) { { attr: "val1" } }
      let(:credentials) { { "api_key" => "api_key", "user_id" => "user_id" } }
      let(:response) { double :response, body_str: body.to_json}

      before(:each) do
        Curl.stub(:get).and_return response
        YAML.stub(:load_file).and_return credentials
      end

      it "fetches result" do
        Curl.should_receive(:get).with(
          "https://api_key@beta-geezeosandbox.geezeo.com/api/v1/users/user_id/accounts"
        ).and_return response
        Fetcher.fetch
      end

      it "returns the result" do
        expect(Fetcher.fetch).to eq(body)
      end

      context "with extra query string" do
        it "connects it" do
          Curl.should_receive(:get).with(
            "https://api_key@beta-geezeosandbox.geezeo.com/api/v1/users/user_id/accounts/extra"
          ).and_return response
          Fetcher.fetch("/extra")
        end
      end
    end
  end
end

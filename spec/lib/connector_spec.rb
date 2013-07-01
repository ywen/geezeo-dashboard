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
    subject(:transaction) { Transaction.new transactions_hash }

    describe ".fetch" do
      let(:account_id) { 12 }
      let(:transactions_hash) { { transactions: [] } }

      before(:each) do
        Fetcher.stub(:fetch).and_return transactions_hash
      end

      it "asks the fetcher to fetch the results" do
        Fetcher.should_receive(:fetch).with("/12/transactions?page=3").and_return transactions_hash
        Transaction.fetch(account_id, 3)
      end

      it "returns a Transaction object" do
        Transaction.stub(:new).with(transactions_hash).and_return transaction
        expect(Transaction.fetch(account_id, 3)).to eq(transaction)
      end
    end

    describe "#transactions_array" do
      let(:transactions_hash) { { transactions: [{ attr: "val" }] } }

      it "returns the transactions array" do
        expect(subject.transactions_array).to eq([{ attr: "val" }])
      end
    end

    describe "#next_page" do
      let(:transactions_hash) { {
        pages: { total_pages: 6, current_page: 1 }
      } }

      it "returns the next page from the current_page" do
        expect(subject.next_page).to eq(2)
      end
    end

    describe "#has_next_page?" do
      context "when the current_page is less than the total page" do
        let(:transactions_hash) { {
          pages: { total_pages: 6, current_page: 5 }
        } }

        it "has next page" do
          expect(subject).to have_next_page
        end
      end

      context "when the current_page is larger than or equal to the total page" do
        let(:transactions_hash) { {
          pages: { total_pages: 6, current_page: 6 }
        } }

        it "doesn't have the next page" do
          expect(subject).not_to have_next_page
        end
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

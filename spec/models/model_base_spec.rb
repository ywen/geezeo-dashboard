require 'spec_helper'

describe ModelBase do
  subject { described_class.new response_hash }

  describe "#balance" do
    let(:response_hash) { { balance: "234.56" } }

    it "returns the balance in cents" do
      expect(subject.balance).to eq(23456)
    end

  end
end

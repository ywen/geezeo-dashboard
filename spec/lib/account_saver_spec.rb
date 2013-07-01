require 'spec_helper'

describe AccountSaver do
  describe ".save" do
    let(:account1) { double :account1, id: 12, name: "name1" }
    let(:account2) { double :account2, id: 14, name: "name2" }

    let(:results) { YAML.load_file("#{Rails.root}/tmp/accounts.yml") }

    it "writes to YAML with id and name" do
      described_class.save([account1, account2])
      expect(results).to eq( 12 => "name1", 14 => "name2" )
    end
  end
end

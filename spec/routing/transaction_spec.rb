require "spec_helper"

describe "accounts/12/transactions" do
  it "goes to accounts/transactions#index" do
    expect( get: "accounts/12/transactions" ).to route_to(
      controller: "accounts/transactions", action: "index", account_id: '12'
    )
  end
end

require "spec_helper"

describe "/transactions" do
  it "goes to transactions#index" do
    expect( get: "/transactions" ).to route_to(
      controller: "transactions", action: "index"
    )
  end
end

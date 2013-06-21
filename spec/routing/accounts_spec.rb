require "spec_helper"

describe "/" do
  it "goes to accounts#index" do
    expect( get: "/" ).to route_to(controller: "accounts", action: "index")
  end
end

describe "accounts" do
  it "goes to accounts#index" do
    expect( get: "accounts" ).to route_to(controller: "accounts", action: "index")
  end
end

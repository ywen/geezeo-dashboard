require "spec_helper"

describe "/" do
  it "goes to user_statistics#index" do
    expect( get: "/" ).to route_to(controller: "user_statistics", action: "index")
  end
end

describe "user_statistics" do
  it "goes to user_statistics#index" do
    expect( get: "user_statistics" ).to route_to(controller: "user_statistics", action: "index")
  end
end

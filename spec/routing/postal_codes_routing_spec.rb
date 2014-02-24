require "spec_helper"

describe PostalCodesController do
  describe "routing" do

    it "routes to #index" do
      get("/postal_codes").should route_to("postal_codes#index")
    end

    it "routes to #new" do
      get("/postal_codes/new").should route_to("postal_codes#new")
    end

    it "routes to #show" do
      get("/postal_codes/1").should route_to("postal_codes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/postal_codes/1/edit").should route_to("postal_codes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/postal_codes").should route_to("postal_codes#create")
    end

    it "routes to #update" do
      put("/postal_codes/1").should route_to("postal_codes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/postal_codes/1").should route_to("postal_codes#destroy", :id => "1")
    end

  end
end

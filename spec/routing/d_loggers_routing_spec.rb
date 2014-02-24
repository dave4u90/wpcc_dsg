require "spec_helper"

describe DLoggersController do
  describe "routing" do

    it "routes to #index" do
      get("/d_loggers").should route_to("d_loggers#index")
    end

    it "routes to #new" do
      get("/d_loggers/new").should route_to("d_loggers#new")
    end

    it "routes to #show" do
      get("/d_loggers/1").should route_to("d_loggers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/d_loggers/1/edit").should route_to("d_loggers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/d_loggers").should route_to("d_loggers#create")
    end

    it "routes to #update" do
      put("/d_loggers/1").should route_to("d_loggers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/d_loggers/1").should route_to("d_loggers#destroy", :id => "1")
    end

  end
end

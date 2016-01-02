require "spec_helper"

describe SaltydogGroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/saltydog_groups").should route_to("saltydog_groups#index")
    end

    it "routes to #new" do
      get("/saltydog_groups/new").should route_to("saltydog_groups#new")
    end

    it "routes to #show" do
      get("/saltydog_groups/1").should route_to("saltydog_groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/saltydog_groups/1/edit").should route_to("saltydog_groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/saltydog_groups").should route_to("saltydog_groups#create")
    end

    it "routes to #update" do
      put("/saltydog_groups/1").should route_to("saltydog_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/saltydog_groups/1").should route_to("saltydog_groups#destroy", :id => "1")
    end

  end
end

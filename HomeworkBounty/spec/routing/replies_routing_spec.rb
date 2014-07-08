require "spec_helper"

describe RepliesController do
  describe "routing" do
		
    it "routes to #index" do
      get("/answers/#{@answer._id}/replies").should route_to("replies#index", :answer_id => @answer._id.to_s)
		end

    it "routes to #new" do
      get("/answers/#{@answer._id}/replies/new").should route_to("replies#new", :answer_id => @answer._id.to_s)
    end

    it "routes to #show" do
      get("/answers/#{@answer._id}/replies/#{@reply._id}").should route_to("replies#show", :answer_id => @answer._id.to_s, :id => @reply._id.to_s)
    end

    it "routes to #edit" do
      get("/answers/#{@answer._id}/replies/#{@reply._id}/edit").should route_to("replies#edit", :answer_id => @answer._id.to_s, :id => @reply._id.to_s)
    end

    it "routes to #create" do
      post("/answers/#{@answer._id}/replies").should route_to("replies#create", :answer_id => @answer._id.to_s)
    end

    it "routes to #update" do
      put("/answers/#{@answer._id}/replies/#{@reply._id}").should route_to("replies#update", :answer_id => @answer._id.to_s, :id => @reply._id.to_s)
    end

    it "routes to #destroy" do
      delete("/answers/#{@answer._id}/replies/#{@reply._id}").should route_to("replies#destroy", :answer_id => @answer._id.to_s, :id => @reply._id.to_s)
    end

  end
end

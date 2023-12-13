require "rails_helper"

RSpec.describe DepartureDatesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/departure_dates").to route_to("departure_dates#index")
    end

    it "routes to #new" do
      expect(get: "/departure_dates/new").to route_to("departure_dates#new")
    end

    it "routes to #show" do
      expect(get: "/departure_dates/1").to route_to("departure_dates#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/departure_dates/1/edit").to route_to("departure_dates#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/departure_dates").to route_to("departure_dates#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/departure_dates/1").to route_to("departure_dates#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/departure_dates/1").to route_to("departure_dates#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/departure_dates/1").to route_to("departure_dates#destroy", id: "1")
    end
  end
end

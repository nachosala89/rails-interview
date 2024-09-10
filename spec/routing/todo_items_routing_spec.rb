require "rails_helper"

RSpec.describe TodoItemsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "todolists/1/todo_items").to route_to("todo_items#index", todo_list_id: "1")
    end

    it "routes to #new" do
      expect(get: "todolists/1/todo_items/new").to route_to("todo_items#new", todo_list_id: "1")
    end

    it "routes to #show" do
      expect(get: "todolists/1/todo_items/1").to route_to("todo_items#show", id: "1", todo_list_id: "1")
    end

    it "routes to #edit" do
      expect(get: "todolists/1/todo_items/1/edit").to route_to("todo_items#edit", id: "1", todo_list_id: "1")
    end


    it "routes to #create" do
      expect(post: "todolists/1/todo_items").to route_to("todo_items#create", todo_list_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "todolists/1/todo_items/1").to route_to("todo_items#update", id: "1", todo_list_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "todolists/1/todo_items/1").to route_to("todo_items#update", id: "1", todo_list_id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "todolists/1/todo_items/1").to route_to("todo_items#destroy", id: "1", todo_list_id: "1")
    end
  end
end

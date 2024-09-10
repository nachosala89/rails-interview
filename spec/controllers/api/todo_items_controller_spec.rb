require 'rails_helper'

RSpec.describe Api::TodoItemsController, type: :controller do
  let!(:todo_list) { create(:todo_list) }
  let!(:todo_item) { create(:todo_item, todo_list: todo_list) }

  context 'when format is HTML' do
    it 'raises a routing error' do
      expect {
        get :index, params: { todo_list_id: todo_list.id }
      }.to raise_error(ActionController::RoutingError, 'Not supported format')
    end
  end

  context 'when format is JSON' do
    describe "GET #index" do
      it "returns http success and all todo_items" do
        get :index, params: { todo_list_id: todo_list.id }, format: :json
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(todo_list.todo_items.count)
      end
    end

    describe "GET #show" do
      it "returns the todo_item" do
        get :show, params: { todo_list_id: todo_list.id, id: todo_item.id }, format: :json
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["id"]).to eq(todo_item.id)
      end

      it "returns 404 if todo_item is not found" do
        get :show, params: { todo_list_id: todo_list.id, id: 0 }, format: :json
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["error"]).to eq("Todo item not found")
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates a new todo_item and returns status created" do
          expect {
            post :create, params: { todo_list_id: todo_list.id, todo_item: { description: "New item", done: false } }, format: :json
          }.to change(TodoItem, :count).by(1)

          expect(response).to have_http_status(:created)
          expect(JSON.parse(response.body)["description"]).to eq("New item")
        end
      end

      context "with invalid attributes" do
        it "returns errors" do
          post :create, params: { todo_list_id: todo_list.id, todo_item: { description: "" } }, format: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)["errors"]).to_not be_empty
        end
      end
    end

    describe "PATCH/PUT #update" do
      context "with valid attributes" do
        it "updates the todo_item and returns the updated item" do
          patch :update, params: { todo_list_id: todo_list.id, id: todo_item.id, todo_item: { description: "Updated description" } }, format: :json
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)["description"]).to eq("Updated description")
        end
      end

      context "with invalid attributes" do
        it "returns errors" do
          patch :update, params: { todo_list_id: todo_list.id, id: todo_item.id, todo_item: { description: "" } }, format: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)["errors"]).to_not be_empty
        end
      end
    end

    describe "DELETE #destroy" do
      it "deletes the todo_item and returns status no_content" do
        expect {
          delete :destroy, params: { todo_list_id: todo_list.id, id: todo_item.id }, format: :json
        }.to change(TodoItem, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end

      it "returns internal_server_error if unable to delete" do
        allow_any_instance_of(TodoItem).to receive(:destroy).and_return(false)
        delete :destroy, params: { todo_list_id: todo_list.id, id: todo_item.id }, format: :json
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end
end


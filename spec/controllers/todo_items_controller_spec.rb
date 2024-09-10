require 'rails_helper'

RSpec.describe TodoItemsController, type: :controller do
  let(:todo_list) { create(:todo_list) }
  let(:todo_item) { create(:todo_item, todo_list: todo_list) }

  # Test for index action
  describe "GET #index" do
    it "assigns all todo_items to @todo_items" do
      get :index, params: { todo_list_id: todo_list.id }
      expect(assigns(:todo_items)).to eq(TodoItem.all)
    end
  end

  # Test for show action
  describe "GET #show" do
    it "assigns the requested todo_item to @todo_item" do
      get :show, params: { id: todo_item.id, todo_list_id: todo_list.id }
      expect(assigns(:todo_item)).to eq(todo_item)
    end
  end

  # Test for new action
  describe "GET #new" do
    it "assigns a new todo_item to @todo_item" do
      get :new, params: { todo_list_id: todo_list.id }
      expect(assigns(:todo_item)).to be_a_new(TodoItem)
    end
  end

  # Test for edit action
  describe "GET #edit" do
    it "assigns the requested todo_item to @todo_item" do
      get :edit, params: { id: todo_item.id, todo_list_id: todo_list.id }
      expect(assigns(:todo_item)).to eq(todo_item)
    end
  end

  # Test for create action
  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new todo_item" do
        expect {
          post :create, params: { todo_list_id: todo_list.id, todo_item: { description: "New item", done: false } }
        }.to change(TodoItem, :count).by(1)
      end

      it "redirects to the todo_list" do
        post :create, params: { todo_list_id: todo_list.id, todo_item: { description: "New item", done: false, todo_list_id: todo_list.id } }
        expect(response).to redirect_to(todo_list_url(todo_list))
      end
    end

    context "with invalid attributes" do
      it "does not save the new todo_item" do
        expect {
          post :create, params: { todo_list_id: todo_list.id, todo_item: { description: "", done: false, todo_list_id: todo_list.id } }
        }.to_not change(TodoItem, :count)
      end

      it "re-renders the new template" do
        post :create, params: { todo_list_id: todo_list.id, todo_item: { description: "", done: false, todo_list_id: todo_list.id } }
        expect(response).to render_template(:new)
      end
    end
  end

  # Test for update action
  describe "PATCH/PUT #update" do
    context "with valid attributes" do
      it "updates the requested todo_item" do
        patch :update, params: { todo_list_id: todo_list.id, id: todo_item.id, todo_item: { description: "Updated description" } }
        todo_item.reload
        expect(todo_item.description).to eq("Updated description")
      end

      it "redirects to the todo_item" do
        patch :update, params: { todo_list_id: todo_list.id, id: todo_item.id, todo_item: { description: "Updated description" } }
        expect(response).to redirect_to(todo_list_todo_item_url(todo_item))
      end
    end

    context "with invalid attributes" do
      it "does not update the todo_item" do
        patch :update, params: { todo_list_id: todo_list.id, id: todo_item.id, todo_item: { description: "" } }
        todo_item.reload
        expect(todo_item.description).to_not eq("")
      end

      it "re-renders the edit template" do
        patch :update, params: { todo_list_id: todo_list.id, id: todo_item.id, todo_item: { description: "" } }
        expect(response).to render_template(:edit)
      end
    end
  end

  # Test for destroy action
  describe "DELETE #destroy" do
    it "deletes the todo_item" do
      todo_item
      expect {
        delete :destroy, params: { todo_list_id: todo_list.id, id: todo_item.id }
      }.to change(TodoItem, :count).by(-1)
    end

    it "redirects to the todo_list" do
      delete :destroy, params: { todo_list_id: todo_list.id, id: todo_item.id }
      expect(response).to redirect_to(todo_list_url(todo_list))
    end
  end

  # Test for toggle_completed action
  describe "PATCH #toggle_completed" do
    it "toggles the completed status of the todo_item" do
      prev_status = todo_item.done
      patch :toggle_completed, params: { todo_list_id: todo_list.id, id: todo_item.id }
      todo_item.reload
      expect(prev_status).to eq(!todo_item.done)
    end
  end
end

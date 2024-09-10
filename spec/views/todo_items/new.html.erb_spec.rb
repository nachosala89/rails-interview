require 'rails_helper'

RSpec.describe "todo_items/new", type: :view do
  let(:todo_list) { create(:todo_list) }

  before(:each) do
    assign(:todo_list, todo_list)
    assign(:todo_item, TodoItem.new(
      description: "MyString",
      done: false,
      todo_list: todo_list
    ))
  end

  it "renders new todo_item form" do
    render

    assert_select "form[action=?][method=?]", todo_list_todo_items_path(todo_list), "post" do

      assert_select "input[name=?]", "todo_item[description]"
    end
  end
end

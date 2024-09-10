require 'rails_helper'

RSpec.describe "todo_items/edit", type: :view do
  let(:todo_list) { create(:todo_list, name: "List") }
  let(:todo_item) { create(:todo_item, todo_list: todo_list ) }

  before(:each) do
    assign(:todo_item, todo_item)
  end

  it "renders the edit todo_item form" do
    render

    assert_select "form[action=?][method=?]", todo_list_todo_item_path(todo_list, todo_item), "post" do

      assert_select "input[name=?]", "todo_item[description]"

    end
  end
end

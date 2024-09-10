require 'rails_helper'

RSpec.describe "todo_items/show", type: :view do
  let(:todo_list) { create(:todo_list) }

  before(:each) do
    assign(:todo_item, TodoItem.create!(
      description: "Description",
      done: false,
      todo_list: todo_list
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Pending/)
  end
end

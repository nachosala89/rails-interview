require 'rails_helper'

RSpec.describe CompleteTodoItemsJob, type: :job do
  let(:todo_list) { create(:todo_list) }
  let!(:todo_item_1) { create(:todo_item, todo_list: todo_list, done: false) }
  let!(:todo_item_2) { create(:todo_item, todo_list: todo_list, done: false) }

  describe "#perform" do
    it "marks all todo_items as done" do
      CompleteTodoItemsJob.perform_now(todo_list.id)
      
      todo_list.reload
      expect(todo_list.todo_items.pluck(:done)).to all(be true)
    end
  end
end

class CompleteTodoItemsJob < ApplicationJob
  queue_as :default

  def perform(todo_list_id)
    todo_list = TodoList.find(todo_list_id)
    
    todo_list.todo_items.find_each { |todo_item| todo_item.update(done: true) }
  end
end

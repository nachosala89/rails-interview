class CompleteTodoItemsJob < ApplicationJob
  queue_as :default

  def perform(todo_list_id)
    todo_list = TodoList.find(todo_list_id)
    
    todo_list.todo_items.update_all(done: true)
  end
end

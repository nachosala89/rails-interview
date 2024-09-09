class TodoList < ApplicationRecord
  has_many :todo_items, dependent: :destroy

  def complete_all
    CompleteTodoItemsJob.perform_later(id)
  end
end
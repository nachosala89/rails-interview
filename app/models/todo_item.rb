class TodoItem < ApplicationRecord
  belongs_to :todo_list
  validates :description, presence: true
  broadcasts_to :todo_list

  scope :done, -> { where(done: true) }
  scope :pending, -> { where(done: false) }
end

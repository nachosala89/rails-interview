require 'rails_helper'

RSpec.describe TodoItem, type: :model do
  let(:todo_list) { create(:todo_list) }
  let(:done_item) { create(:todo_item, todo_list: todo_list, done: true) }
  let(:pending_item) { create(:todo_item, todo_list: todo_list, done: false) }
  
  describe 'associations' do
    it { should belong_to(:todo_list) }
  end

  describe 'validations' do
    it { should validate_presence_of(:description) }
  end

  describe 'scopes' do
    describe '.done' do
      it 'includes items marked as done' do
        expect(TodoItem.done).to include(done_item)
        expect(TodoItem.done).not_to include(pending_item)
      end
    end

    describe '.pending' do
      it 'includes items that are pending' do
        expect(TodoItem.pending).to include(pending_item)
        expect(TodoItem.pending).not_to include(done_item)
      end
    end
  end
end
module Api
  class TodoListsController < ApiController
    # GET /api/todolists
    def index
      @todo_lists = TodoList.all

      render json: @todo_lists, status: :ok
    end
  end
end

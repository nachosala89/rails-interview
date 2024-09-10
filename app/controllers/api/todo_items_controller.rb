module Api
  class TodoItemsController < ApiController
    before_action :set_todo_item, only: %i[ show edit update destroy ]
    before_action :set_todo_list

    # GET /api/todolist/:todo_list_id/todo_items
    def index
      @todo_items = @todo_list.todo_items
      render json: @todo_items, status: :ok
    end

    # GET /api/todolist/:todo_list_id/todo_items/1
  def show
    render json: @todo_item, status: :ok
  end

  # POST /api/todolist/:todo_list_id/todo_items
  def create
    @todo_item = TodoItem.new(todo_item_params)
    @todo_item.todo_list = @todo_list

    if @todo_item.save
      render json: @todo_item, status: :created
    else
      render json: { errors: @todo_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/todolist/:todo_list_id/todo_items/1
  def update
    if @todo_item.update(todo_item_params)
      render json: @todo_item
    else
      render json: { errors: @todo_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/todolist/:todo_list_id/todo_items/1
  def destroy
    if @todo_item.destroy
      render json: {}, status: :no_content
    else
      render json: {}, status: :internal_server_error
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_item
      @todo_item = TodoItem.find_by(id: params[:id])

      render json: { error: 'Todo item not found' }, status: :not_found unless @todo_item
    end

    # Only allow a list of trusted parameters through.
    def todo_item_params
      params.require(:todo_item).permit(:description, :done)
    end

    def set_todo_list
      @todo_list = TodoList.find_by(id: params[:todo_list_id])

      render json: { error: 'Todo list not found' }, status: :not_found unless @todo_list
    end
  end
end
class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: %i[ show edit update destroy toggle_completed ]
  before_action :set_todo_list

  # GET todolists/:todo_list_id/todo_items
  def index
    @todo_items = TodoItem.all
  end

  # GET /todo_items/1
  def show
  end

  # GET /todo_items/new
  def new
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.build
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /todo_items/1/edit
  def edit
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # POST /todo_items
  def create
    @todo_item = TodoItem.new(todo_item_params)
    @todo_item.todo_list = @todo_list

    respond_to do |format|
      if @todo_item.save
        format.html { redirect_to todo_list_url(@todo_item.todo_list), notice: "Todo item was successfully created." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todo_items/1
  def update
    respond_to do |format|
      if @todo_item.update(todo_item_params)
        format.html { redirect_to todo_list_todo_item_url(@todo_item), notice: "Todo item was successfully updated." }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_items/1
  def destroy
    @todo_item.destroy

    respond_to do |format|
      format.html { redirect_to todo_list_url(@todo_item.todo_list), notice: "Todo item was successfully destroyed." }
    end
  end

  def toggle_completed
    @todo_item.update(done: !@todo_item.done)
    respond_to do |format|
      format.html { redirect_to todo_list_url(@todo_item.todo_list), notice: "Todo item was successfully updated." }
      format.turbo_stream
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_item
      @todo_item = TodoItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_item_params
      params.require(:todo_item).permit(:description, :done, :todo_list_id)
    end

    def set_todo_list
      @todo_list = TodoList.find_by(id: params[:todo_list_id])
    end
end

class TodoListsController < ApplicationController
  # GET /todolists
  def index
    @todo_lists = TodoList.all

    respond_to :html
  end

  # GET /todolists/new
  def new
    @todo_list = TodoList.new

    respond_to :html
  end

  # POST /todo_lists
  def create
    @todo_list = TodoList.new(todo_list_params)

    respond_to do |format|
      if @todo_list.save
        format.html { redirect_to todo_list_url(@todo_list), notice: "Todo item was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # GET /todolists/1 or /todolists/1.json
  def show
    @todo_list = TodoList.find(params[:id])

    case params[:filter]
    when 'done'
      @todo_items = @todo_list.todo_items.done
    when 'pending'
      @todo_items = @todo_list.todo_items.pending
    else
      @todo_items = @todo_list.todo_items
    end

    respond_to :html
  end

  # POST /todolists/1/complete_todo_items
  def complete_todo_items
    @todo_list = TodoList.find(params[:id])
    @todo_list.complete_all

    respond_to :html
  end

  private
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_list_params
      params.require(:todo_list).permit(:name)
    end
end

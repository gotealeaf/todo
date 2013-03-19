class TodosController < ApplicationController
  before_filter :ensure_sign_in

  def index
    @todos = current_user.todos
    @todo = Todo.new
  end

  def admin_index
    @todos = Todo.all
    render :index
  end

  def new
    @todo = Todo.new
  end

  def show
    @todo = Todo.find_by_token(params[:id])
  end

  def create
    @todo = Todo.new(params[:todo])
    if @todo.save_with_tags
      EmailWorker.perform_async(current_user.id, @todo.id)
      redirect_to root_path
    else
      render :new
    end
  end
end

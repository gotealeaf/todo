class TodosController < ApplicationController
  before_filter :ensure_sign_in

  def index
    @todos = Todo.all
    @todo = Todo.new
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
      AppMailer.notify_on_new_todo(current_user, @todo).deliver
      redirect_to root_path
    else
      render :new
    end
  end
end

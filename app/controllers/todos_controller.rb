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
    @todo = Todo.find(params[:id])
  end

  def create
    @todo = Todo.new(params[:todo])
    if @todo.save_with_tags
      redirect_to root_path
    else
      render :new
    end
  end
end

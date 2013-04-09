class TodosController < AuthenticatedController

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
    credit = Credit.new(current_user)

    if @todo.save_with_tags
      if UserLevelPolicy.new(current_user).premium?
        credit = credit - 1
      else
        credit = credit - 2
      end

      credit.save

      if credit.depleted?
        AppMailer.notify_insufficient_credit(current_user).deliver
      elsif credit.low_balance?
        AppMailer.notify_low_balance(current_user).deliver
      end

      redirect_to root_path
    else
      render :new
    end
  end
end

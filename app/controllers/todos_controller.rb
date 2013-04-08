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
    if @todo.save_with_tags
      if UserLevelPolicy.new(current_user).premium?
        new_credit_balance = current_user.current_credit_balance - 1
      else
        new_credit_balance = current_user.current_credit_balance - 2
      end

      current_user.current_credit_balance = new_credit_balance
      current_user.save

      if new_credit_balance < 0
        AppMailer.notify_insufficient_credit(current_user).deliver
      elsif current_user.current_credit_balance < 10
        AppMailer.notify_low_balance(current_user).deliver
      end

      redirect_to root_path
    else
      render :new
    end
  end
end

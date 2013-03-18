class EmailWorker
  include Sidekiq::Worker

  def perform(user_id, todo_id)
    user = User.find(user_id)
    todo = Todo.find(todo_id)
    AppMailer.notify_on_new_todo(user, todo).deliver
  end
end

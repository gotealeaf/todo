class AddAndDueAtToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :due_at, :date_time
  end
end

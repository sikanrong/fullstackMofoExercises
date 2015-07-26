class AddColumnNameToTodo < ActiveRecord::Migration
  def change
    add_column :todos, :content, :string
  end
end

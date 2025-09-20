class NewUserTables < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :phone, :string
    add_column :users, :linkedin, :string
    add_column :users, :github, :string
    add_column :users, :summary, :text
  end
end

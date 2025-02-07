class AddLoginToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :login, :string
  end
end

class AddMoreFieldToAccount < ActiveRecord::Migration[8.0]
  def change
    add_column :accounts, :password, :string
    add_column :accounts, :password_confirmation, :string
  end
end

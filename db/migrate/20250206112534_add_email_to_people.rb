class AddEmailToPeople < ActiveRecord::Migration[8.0]
  def change
    add_column :people, :email, :string
  end
end

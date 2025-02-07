class AddUniqueIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :email, unique: true
  end
end
# Rails validations fail, the database will prevent duplicate emails

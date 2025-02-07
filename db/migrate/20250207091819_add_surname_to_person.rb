class AddSurnameToPerson < ActiveRecord::Migration[8.0]
  def change
    add_column :people, :surname, :string
  end
end

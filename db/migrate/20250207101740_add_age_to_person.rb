class AddAgeToPerson < ActiveRecord::Migration[8.0]
  def change
    add_column :people, :age, :integer
  end
end

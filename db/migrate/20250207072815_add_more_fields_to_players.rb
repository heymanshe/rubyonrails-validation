class AddMoreFieldsToPlayers < ActiveRecord::Migration[8.0]
  def change
    add_column :players, :salary, :decimal
    add_column :players, :win_percentage, :float
    add_column :players, :losses, :integer
    add_column :players, :draws, :integer
    add_column :players, :experience, :integer
  end
end

class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :points
      t.integer :games_played
      t.integer :age
      t.float :rating

      t.timestamps
    end
  end
end

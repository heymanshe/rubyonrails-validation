class CreateVoters < ActiveRecord::Migration[8.0]
  def change
    create_table :voters do |t|
      t.string :name
      t.integer :age

      t.timestamps
    end
  end
end

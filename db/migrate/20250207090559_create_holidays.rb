class CreateHolidays < ActiveRecord::Migration[8.0]
  def change
    create_table :holidays do |t|
      t.string :name
      t.integer :year

      t.timestamps
    end
  end
end

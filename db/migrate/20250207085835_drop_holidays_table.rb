class DropHolidaysTable < ActiveRecord::Migration[8.0]
  def up
    drop_table :holidays, if_exists: true
  end

  def down
    create_table :holidays do |t|
      t.string :name
      t.yaer :year
      t.timestamps
    end
  end
end

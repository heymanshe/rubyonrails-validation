class CreateComputers < ActiveRecord::Migration[8.0]
  def change
    create_table :computers do |t|
      t.string :market
      t.string :device_type
      t.string :mouse
      t.string :trackpad

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.text :bio
      t.string :password
      t.string :registration_number

      t.timestamps
    end
  end
end

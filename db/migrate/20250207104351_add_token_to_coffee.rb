class AddTokenToCoffee < ActiveRecord::Migration[8.0]
  def change
    add_column :coffees, :token, :string
  end
end

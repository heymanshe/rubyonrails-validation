class AddTermsOfServiceToPeople < ActiveRecord::Migration[8.0]
  def change
    add_column :people, :terms_of_service, :boolean
  end
end

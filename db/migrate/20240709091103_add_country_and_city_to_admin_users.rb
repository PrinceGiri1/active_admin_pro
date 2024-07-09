class AddCountryAndCityToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :country, :string
    add_column :admin_users, :state, :string
    add_column :admin_users, :city, :string
  end
end

class AddNameFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
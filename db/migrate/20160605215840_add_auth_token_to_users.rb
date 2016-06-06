class AddAuthTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :uid, :string, unique: true
    add_column :users, :provider, :string
    add_column :users, :auth_token, :string, unique: true
  end
end

# This migration comes from user_manager_client_engine (originally 20120611071409)
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :role
      t.string :photo_url

      t.timestamps
    end
  end
end

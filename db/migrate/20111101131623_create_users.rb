class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :identifier, :limit => 20
      t.string :access_token
      t.string :first_name
      t.string :last_name
      t.string :email
      t.timestamps
    end
  end
end

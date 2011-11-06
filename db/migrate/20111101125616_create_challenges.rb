class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.integer :user_id
      t.integer :theme_id
      t.integer :score
      t.timestamps
    end
  end
end

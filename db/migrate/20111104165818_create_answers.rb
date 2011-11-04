class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :name
      t.boolean :correct
      t.integer :challenge_id
      t.references :answerable, :polymorphic => true
      t.timestamps
    end
  end
end

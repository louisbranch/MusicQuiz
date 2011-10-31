class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :artist_id
      t.string :name
      t.string :file_path

      t.timestamps
    end
  end
end

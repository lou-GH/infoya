class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :manufacturer_id
      t.integer :location_id
      t.integer :genre_tag_id
      t.integer :notification_id
      
      t.text :introduction, null: false


      t.timestamps
    end
  end
end

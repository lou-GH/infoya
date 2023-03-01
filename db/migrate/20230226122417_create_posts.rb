class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.references :manufacturer, foreign_key: true
      t.references :location, foreign_key: true
      t.references :genre_tag, foreign_key: true
      t.references :notification, foreign_key: true

      t.string :introduction,   null: false, default: ""


      t.timestamps
    end
  end
end

class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|


      t.references :manufacturer, foreign_key: true

      t.string :name,           null: false, default: ""
      t.string :postal_code,    null: false, default: ""
      t.string :prefecture,     null: false, default: ""
      t.string :address,        null: false, default: ""
      t.string :location_image, null: false
      t.string :introduction,   null: false, default: ""

      t.timestamps
    end
  end
end

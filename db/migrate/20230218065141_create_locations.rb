class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|


      t.references :manufacturer, foreign_key: true

      t.string :name,           null: false
      t.string :postal_code,    null: false
      t.string :prefecture,     null: false
      t.string :address,        null: false
      t.string :introduction,   null: false

      t.timestamps
    end
  end
end

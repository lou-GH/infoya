class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.references :manufacturer, foreign_key: true

      t.text :comment

      t.timestamps
    end
  end
end

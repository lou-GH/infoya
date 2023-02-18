class AddIntroductionsToManufacturers < ActiveRecord::Migration[6.1]
  def change
    add_column :manufacturers, :introduction, :string
  end
end

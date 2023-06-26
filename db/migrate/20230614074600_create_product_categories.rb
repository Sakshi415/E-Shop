class CreateProductCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :product_categories do |t|
      t.references :product, foreign_key: true, index: true
      t.references :category, foreign_key: true, index: true

      t.timestamps
    end
  end
end

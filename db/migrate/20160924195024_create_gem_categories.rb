class CreateGemCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :gem_categories do |t|
      t.string :name
      t.string :description
      t.integer :parent_id

      t.timestamps
    end

    add_foreign_key :gem_categories, :gem_categories, column: :parent_id
  end
end

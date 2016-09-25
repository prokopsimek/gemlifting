class AddSlugToGemObjectsAndGemCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :gem_objects, :slug, :string, null: false
    add_column :gem_categories, :slug, :string, null: false

    add_index :gem_objects, :slug, unique: true
    add_index :gem_categories, :slug, unique: true
  end
end

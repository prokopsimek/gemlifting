class AddUniqueIndexForNameToGemCategories < ActiveRecord::Migration[5.0]
  def change
    add_index :gem_categories, :name, unique: true
  end
end

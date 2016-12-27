class ChangeUniqIndexOnNameInGemCategories < ActiveRecord::Migration[5.0]
  def change
    remove_index :gem_categories, :name
    add_index :gem_categories, [:name, :parent_id], unique: true
  end
end

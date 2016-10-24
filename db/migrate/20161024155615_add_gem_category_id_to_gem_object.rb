class AddGemCategoryIdToGemObject < ActiveRecord::Migration[5.0]
  def change
    add_reference :gem_objects, :gem_category, foreign_key: true
  end
end

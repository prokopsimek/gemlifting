class AddMoreAttributesToGemObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :gem_objects, :description, :text
    add_column :gem_objects, :readme, :text
    add_column :gem_objects, :git_url, :string
    add_column :gem_objects, :ssh_url, :string
  end
end

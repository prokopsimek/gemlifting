class AddRubygemsSyncAtToGemObject < ActiveRecord::Migration[5.0]
  def change
    add_column :gem_objects, :rubygems_sync_at, :datetime
  end
end

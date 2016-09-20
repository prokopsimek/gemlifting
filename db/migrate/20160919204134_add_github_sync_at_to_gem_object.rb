class AddGithubSyncAtToGemObject < ActiveRecord::Migration[5.0]
  def change
    add_column :gem_objects, :github_sync_at, :datetime
  end
end

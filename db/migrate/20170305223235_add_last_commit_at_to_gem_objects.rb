class AddLastCommitAtToGemObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :gem_objects, :last_commit_at, :datetime
  end
end

class AddGithubStatsColumnsToGemObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :gem_objects, :stargazers_count, :integer
    add_column :gem_objects, :watchers_count, :integer
    add_column :gem_objects, :forks_count, :integer
    add_column :gem_objects, :open_issues_count, :integer
  end
end

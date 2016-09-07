class CreateGemObjects < ActiveRecord::Migration[5.0]
  def change
    create_table :gem_objects do |t|
      t.string :name, null: false, uniq: true
      t.integer :downloads, default: 0, null: false
      t.string :version, null: false
      t.integer :version_downloads, default: 0, null: false
      t.string :platform
      t.string :authors
      t.string :info
      t.text :licenses, array: true, default: []
      t.string :sha
      t.string :project_uri
      t.string :gem_uri
      t.string :homepage_uri
      t.string :wiki_uri
      t.string :documentation_uri
      t.string :mailing_list_uri
      t.string :source_code_uri
      t.string :bug_tracker_uri

      t.timestamps
    end
  end
end

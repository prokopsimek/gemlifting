class CreateGemVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :gem_versions do |t|
      t.references :gem_object, foreign_key: true
      t.string :authors
      t.datetime :built_at
      t.text :description
      t.integer :downloads_count, default: 0, null: false
      t.string :number
      t.string :summary
      t.string :platfrom
      t.string :rubygems_version
      t.string :ruby_version
      t.boolean :prerelease, default: 'false'
      t.text :licenses, array: true, default: []
      t.string :sha

      t.timestamps
    end
  end
end

class CreateProposals < ActiveRecord::Migration[5.0]
  def change
    create_table :proposals do |t|
      t.references :proposed, polymorphic: true
      t.text :note
      t.string :proposed_attribute
      t.text :proposed_value

      t.timestamps
    end
  end
end

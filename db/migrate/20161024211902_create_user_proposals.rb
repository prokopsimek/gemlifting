class CreateUserProposals < ActiveRecord::Migration[5.0]
  def change
    create_table :user_proposals do |t|
      t.references :user, foreign_key: true
      t.references :proposal, foreign_key: true

      t.timestamps
    end

    add_index :user_proposals, [:user_id, :proposal_id], unique: true
  end
end

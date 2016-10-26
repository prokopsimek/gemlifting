class Proposal < ApplicationRecord
  belongs_to :proposed, polymorphic: true
  has_many :user_proposals
  has_many :proposing_users, through: :user_proposals, source: :user

  validates :proposed_id, :proposed_type, presence: true
  validates :proposed_type, inclusion: { in: %w(GemObject GemCategory) }
end

class Proposal < ApplicationRecord
  belongs_to :proposed, polymorphic: true
  has_many :proposing_users, class_name: 'UserProposal', source: :user

  validates :proposed_id, :proposed_type, presence: true
  validates :proposed_type, inclusion: { in: %w(GemObject GemCategory) }
end

class Proposal < ApplicationRecord
  PROPOSED_TYPES = %w(GemObject GemCategory).freeze

  belongs_to :proposed, polymorphic: true
  has_many :user_proposals
  has_many :proposing_users, through: :user_proposals, source: :user

  validates :proposed_id, :proposed_type, presence: true
  validates :proposed_type, inclusion: { in: PROPOSED_TYPES }
  validates :proposed_attribute, presence: true, if: 'note.blank?'
  validates :proposed_attribute, inclusion: { in: %w(category_id) }, if: :is_gem_object_type?
  validates :proposed_attribute, inclusion: { in: %w(name) }, if: :is_gem_category_type?

  PROPOSED_TYPES.each do |p|
    define_method "is_#{p.underscore}_type?" do
      self.proposed_type == p
    end
  end

end

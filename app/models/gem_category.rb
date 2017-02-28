class GemCategory < ApplicationRecord
  include Proposable
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_many :gem_objects, inverse_of: :gem_category, dependent: :nullify
  belongs_to :parent, inverse_of: :subcategories, class_name: GemCategory
  has_many :subcategories, inverse_of: :parent, class_name: GemCategory, foreign_key: :parent_id, dependent: :destroy

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :parent_id
  validate :parent_cannot_have_parent, :cannot_be_nested_in_self

  scope :parental, -> { where(parent_id: nil) }
  scope :children, -> { where.not(parent_id: nil) }

  def is_parental?
    parent.nil?
  end

  def top_downloaded_gems
    gem_objects.order(downloads: :desc).limit(10)
  end

  def categories_with_same_parent
    return [] if parent.nil?
    parent.subcategories.where.not(id: id).order(:name)
  end

  private

  def parent_cannot_have_parent
    if parent.present? && !parent.is_parental?
      errors.add(:parent, 'has already parental category. Cannot have nested category in a subcategory')
    end
  end

  def cannot_be_nested_in_self
    if id.present? && parent_id.present? && id == parent_id
      errors.add(:parent, 'cannot be self')
    end
  end

  def slug_candidates
    [
      :name,
      [:name, 'category'],
      [:name, (parent.present? ? parent.name : '')]
    ]
  end

end

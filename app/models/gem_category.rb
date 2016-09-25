class GemCategory < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :gem_object_in_gem_categories, inverse_of: :gem_category
  has_many :gem_objects, through: :gem_object_in_gem_categories, inverse_of: :gem_categories
  belongs_to :parent, inverse_of: :subcategories, class_name: GemCategory
  has_many :subcategories, inverse_of: :parent, class_name: GemCategory, foreign_key: :parent_id

  validate :parent_cannot_have_parent, :cannot_be_nested_in_self

  scope :parental, -> { where(parent_id: nil) }

  def is_parental?
    parent.nil?
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

end

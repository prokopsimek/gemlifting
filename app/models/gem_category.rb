class GemCategory < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :gem_object_in_gem_categories, inverse_of: :gem_category
  has_many :gem_objects, through: :gem_object_in_gem_categories, inverse_of: :gem_categories

  validate :parent_cannot_have_parent

  def is_parental?
    parent.nil?
  end

  private

  def parent_cannot_have_parent
    if parent.present? && !parent.is_parental?
      errors.add(:parent, 'has already parental category. Cannot have nested category in a subcategory')
    end
  end

end

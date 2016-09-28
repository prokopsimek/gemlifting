class GemObjectInGemCategory < ApplicationRecord
  belongs_to :gem_object
  belongs_to :gem_category

  validates :gem_object, :gem_category, presence: true
  validates_uniqueness_of :gem_object_id, scope: :gem_category_id
  validate :gem_object_cannot_be_in_parental_category, :limit_one_category_for_gem_object
  
  private

  def gem_object_cannot_be_in_parental_category
    if gem_category.present? && gem_category.is_parental?
      errors.add(:gem_object, 'cannot be in parental category')
    end
  end

  def limit_one_category_for_gem_object
    if gem_object_id && GemObjectInGemCategory.where(gem_object_id: gem_object_id).count >= 1
      errors.add(:gem_object, 'can have only 1 category')
    end
  end
end

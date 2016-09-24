class GemObjectInGemCategory < ApplicationRecord
  belongs_to :gem_object
  belongs_to :gem_category

  validates :gem_object, :gem_category, presence: true
  validates_uniqueness_of :gem_object_id, scope: :gem_category_id
  validate :gem_object_cannot_be_in_parental_category
  
  private

  def gem_object_cannot_be_in_parental_category
    if gem_category.present? && gem_category.is_parental?
      errors.add(:gem_object, 'cannot be in parental category')
    end
  end
end

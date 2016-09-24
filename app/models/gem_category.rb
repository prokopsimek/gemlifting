class GemCategory < ApplicationRecord

  validates :parent_cannot_have_parent

  def is_parental?
    parent.nil?
  end

  private

  def parent_cannot_have_parent
    unless parent.is_parental?
      errors.add(:parent, 'has already parental category. Cannot have nested category in a subcategory.')
    end
  end

end

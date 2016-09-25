class GemVersion < ApplicationRecord
  belongs_to :gem_object

  validates :gem_object, presence: true
end

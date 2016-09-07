class GemObject < ApplicationRecord
  has_many :versions, class_name: GemVersion
  alias gem_versions versions
end

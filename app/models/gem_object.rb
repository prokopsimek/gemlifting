class GemObject < ApplicationRecord
  has_many :versions, class_name: GemVersions
  alias gem_versions versions
end

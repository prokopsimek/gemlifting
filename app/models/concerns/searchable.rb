module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model, Elasticsearch::Model::Callbacks

    def self.index_name
      "#{self.table_name}_#{Rails.env}"
    end

  end

end

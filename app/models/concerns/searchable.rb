module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model, Elasticsearch::Model::Callbacks
  end

end

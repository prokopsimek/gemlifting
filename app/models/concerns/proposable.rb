module Proposable
  extend ActiveSupport::Concern

  included do
    has_many :proposals, as: :proposed
  end

end

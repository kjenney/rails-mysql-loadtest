class Supplier < ApplicationRecord
  scope :by_name, -> { order(:name) }
end

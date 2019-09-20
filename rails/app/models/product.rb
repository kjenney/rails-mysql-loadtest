class Product < ApplicationRecord
  belongs_to :supplier
  scope :by_name, -> { order(:name) }
end

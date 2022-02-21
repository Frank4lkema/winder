class Spot < ApplicationRecord
  validates :spot_id, uniqueness: true
end

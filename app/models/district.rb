class District < ApplicationRecord
  has_many :mandals
  validates :dist_id, uniqueness: true
end

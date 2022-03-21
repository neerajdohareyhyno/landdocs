class Mandal < ApplicationRecord
  belongs_to :district
  has_many :villages
end

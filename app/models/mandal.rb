class Mandal < ApplicationRecord
  belongs_to :district
  has_many :villages

  validates :mand_id, uniqueness: true
end

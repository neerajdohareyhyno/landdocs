class Village < ApplicationRecord
  belongs_to :mandal
  has_many :surveys

  validates :vill_id, uniqueness: true
end

class Survey < ApplicationRecord
  belongs_to :village
  has_many :land_records
end

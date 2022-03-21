class Village < ApplicationRecord
  belongs_to :mandal
  has_many :surveys
end

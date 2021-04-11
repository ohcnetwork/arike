class State < ApplicationRecord
  has_many :districts
  has_many :facilities
end

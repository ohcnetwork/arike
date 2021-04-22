class State < ApplicationRecord
  has_many :districts, dependent: :destroy
  has_many :facilities, dependent: :destroy
end

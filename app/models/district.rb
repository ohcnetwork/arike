class District < ApplicationRecord
  belongs_to :state
  has_many :lsg_bodies, dependent: :destroy
  has_many :facilities, dependent: :destroy
end

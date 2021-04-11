class District < ApplicationRecord
  belongs_to :state
  has_many :lsg_bodies
  has_many :facilities
end

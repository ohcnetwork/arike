class LsgBody < ApplicationRecord
  has_many :wards, dependent: :restrict_with_error
  has_many :facilities,
           inverse_of: :lsg_body_info,
           dependent: :restrict_with_error
  belongs_to :district
end

class Ward < ApplicationRecord
  belongs_to :lsg_body
  has_many :facilities, inverse_of: :ward_info, dependent: :restrict_with_error
end

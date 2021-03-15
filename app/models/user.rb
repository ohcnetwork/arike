class User < ApplicationRecord
  ROLES = %w(superuser primary_nurse secondary_nurse)

  validates :role, inclusion: {
    in: ROLES,
    message: "%{value} is not a valid role"
  }
end

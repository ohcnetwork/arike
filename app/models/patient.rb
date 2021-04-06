class Patient < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :family_details, dependent: :restrict_with_error
  belongs_to :facility

  def add_users(user_ids)
    user_ids.each do |user_id|
      self.users << User.find(user_id)
    end
  end
end

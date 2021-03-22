class Patient < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :family_details

  def add_users(user_ids)
    user_ids.each do |user_id|
      self.users << User.find_by_id(user_id)
    end
  end

end

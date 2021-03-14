class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # https://github.com/rails/rails/pull/34480
  self.implicit_order_column = "created_at"
end

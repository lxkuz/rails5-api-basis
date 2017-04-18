class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :order_by, -> (field) do
    order(field)
  end

end
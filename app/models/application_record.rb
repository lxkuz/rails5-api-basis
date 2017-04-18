class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :order_by, (lambda do |field|
    order(field)
  end)
end

class TicketKind < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :tickets, dependent: :restrict_with_error
end

class TicketKind < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :tickets, dependent: :restrict
end

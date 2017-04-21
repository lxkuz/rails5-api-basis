class Ticket < ApplicationRecord
  belongs_to :customer, class_name: User
  belongs_to :agent, class_name: User
  belongs_to :ticket_kind

  validates :name, :description,
            :ticket_kind, :customer, presence: true

  STATUSES = [:closed, :waiting].freeze

  enum status: Hash[STATUSES.map { |i| [i, i] }]
end

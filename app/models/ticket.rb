class Ticket < ApplicationRecord
  belongs_to :customer, class_name: 'User'
  belongs_to :agent, class_name: 'User'
  belongs_to :ticket_kind

  validates :name, :description,
            :ticket_kind, :customer, presence: true

  validates :closing_description, :agent, presence: true, if: 'closed?'
  before_save :fill_closed_at

  STATUSES = [:closed, :waiting].freeze

  enum status: Hash[STATUSES.map { |i| [i, i.to_s] }]

  private

  def fill_closed_at
    self.closed_at = Time.now if closed? && closed_at.nil?
  end
end

class Report < ApplicationRecord
  validates :title, presence: true

  before_save :fill_report_data

  private

  def fill_report_data
    return if report_to || report_from || data
    report_to = Time.now
    report_from = report_to - 1.month

    tickets = Ticket.where('closed_at >= ? AND closed_at <= ?', report_to, report_from)
    agents_count_data = Ticket.group(:agent_id).where('closed_at >= ? AND closed_at <= ?', report_to, report_from).count
    data = {
      count: tickets.count,
      agents_count: agents_count_data
    }
  end
end

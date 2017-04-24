class Report < ApplicationRecord
  validates :title, presence: true

  before_create :fill_report_data

  def agents_count_data
    agents_counts = data['agents_count']
    agent_ids = agents_counts.keys
    agents = User.where id: agent_ids
    agents.map do |agent|
      {
        email: agent.email,
        count: agents_counts[agent.id.to_s]
      }
    end
  end

  private

  def fill_report_data
    self.report_to = Time.now
    self.report_from = report_to - 1.month
    closed_at_query = 'closed_at <= ? AND closed_at >= ?'
    tickets_scope = Ticket.where(closed_at_query, report_to, report_from)
    agents_count_data = tickets_scope.group(:agent_id).count
    self.data = {
      count: tickets_scope.count,
      agents_count: agents_count_data,
      full: tickets_scope.map do |ticket|
        {
          name: ticket.name,
          customer: ticket.customer.email,
          description: ticket.description,
          agent: ticket.agent.email,
          closing_description: ticket.closing_description,
          closed_at: ticket.closed_at.strftime('%d/%M/%Y')
        }
      end
    }
  end
end

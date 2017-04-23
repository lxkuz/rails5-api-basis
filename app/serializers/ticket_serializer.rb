class TicketSerializer < BaseSerializer
  attributes :id, :name, :description, :ticket_kind_id,
             :status, :closing_description
  belongs_to :customer
  belongs_to :ticket_kind
end

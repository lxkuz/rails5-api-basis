class TicketSerializer < BaseSerializer
  attributes :id, :name, :description, :ticket_kind_id
  belongs_to :customer
  belongs_to :ticket_kind
end

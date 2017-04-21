class TicketSerializer < BaseSerializer
  attributes :id, :name, :description
  belongs_to :customer
end

# frozen_string_literal: true
class User < ApplicationRecord
  devise :database_authenticatable

  validates :role, presence: true
  validates :email, uniqueness: true

  ROLES = [:customer, :admin, :agent].freeze
  enum role: Hash[ROLES.map { |i| [i, i.to_s] }]

  has_many :tickets, 
    foreign_key: 'customer_id', 
    dependent: :restrict_with_exception
  has_many :closed_tickets,
    foreign_key: 'agent_id',
    class_name: 'Ticket',
    dependent: :restrict_with_exception
end

# frozen_string_literal: true
class User < ApplicationRecord
  devise :database_authenticatable

  validates :role, presence: true

  ROLES = [:customer, :admin, :agent].freeze
  enum role: Hash[ROLES.map { |i| [i, i.to_s] }]

  has_many :tickets, as: :customer, dependent: :restrict_with_exception
  has_many :closed_tickets, as: :agent, dependent: :restrict_with_exception
end

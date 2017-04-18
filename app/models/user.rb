# frozen_string_literal: true
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :role, presence: true

  ROLES = [:customer, :admin, :agent].freeze

  has_many :tickets, as: :customer, dependent: :restrict
  has_many :closed_tickets, as: :agent, dependent: :restrict

  enum status: Hash[ROLES.map { |i| [i, i] }]
end

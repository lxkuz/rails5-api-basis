# frozen_string_literal: true
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :role, presence: true

  ROLES = [:customer, :admin, :agent].freeze
  enum status: Hash[ROLES.map { |i| [i, i] }]

  has_many :tickets, as: :customer, dependent: :restrict_with_exception
  has_many :closed_tickets, as: :agent, dependent: :restrict_with_exception
end

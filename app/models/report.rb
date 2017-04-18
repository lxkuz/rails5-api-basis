class Report < ApplicationRecord
  validates :title, :report_from, :report_to, presence: true
end

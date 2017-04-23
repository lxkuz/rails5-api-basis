class ReportSerializer < BaseSerializer
  attributes :id, :title, :file

  attribute :report_from do
    object.report_from.to_i
  end

  attribute :report_to do
    object.report_to.to_i
  end
end

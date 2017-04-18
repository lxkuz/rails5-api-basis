module Api
  module V1
    class ReportsController < ResourcesController
      def resource_params(params)
        params.permit(:report_from, :report_to, :title)
      end
    end
  end
end

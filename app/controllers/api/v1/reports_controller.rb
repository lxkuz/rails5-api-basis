module Api
  module V1
    class ReportsController < ResourcesController
      def resource_params
        params.permit(:title)
      end
    end
  end
end

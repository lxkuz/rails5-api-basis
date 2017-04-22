module Api
  module V1
    class TicketKindsController < ResourcesController
      def resource_params
        params.permit(:name)
      end
    end
  end
end

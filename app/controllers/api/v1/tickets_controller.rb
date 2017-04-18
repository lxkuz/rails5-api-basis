module Api
  module V1
    class TicketsController < ResourcesController
      def resource_params(params)
        params.permit(:name, :description, :ticket_type_id,
                      :agent_id, :customer_id, :closed_at, :status, :closing_description)
      end
    end
  end
end

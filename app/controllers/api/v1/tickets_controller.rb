module Api
  module V1
    class TicketsController < ResourcesController
      def create
        puts "CREATE!!!!!"
        record = Ticket.new resource_params
        record.customer = current_user
        authorize! :create, record
        if record.save
          render json: serialize(record).to_json
        else
          render json: serialize_errors(record).to_json, status: 406
        end
      end

      def resource_params
        params.permit(:name, :description, :ticket_kind_id,
        :status, :closing_description)
      end
    end
  end
end

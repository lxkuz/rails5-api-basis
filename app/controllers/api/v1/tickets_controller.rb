module Api
  module V1
    class TicketsController < ResourcesController
      has_scope :order_by, default: 'status desc, created_at desc'

      def create
        record = Ticket.new resource_params
        record.customer = current_user
        record.agent = current_user if resource_params[:status] == 'closed'
        authorize! :create, record
        if record.save
          render json: serialize(record).to_json
        else
          render json: serialize_errors(record).to_json, status: 406
        end
      end

      def update
        resource.agent = current_user if resource_params[:status] == 'closed'
        super
      end

      private

      def resource_params
        case current_user.role
        when 'customer'
          customer_params
        else
          all_params
        end
      end

      def customer_params
        params.permit(:name, :description, :ticket_kind_id)
      end

      def all_params
        params.permit(:name, :description, :ticket_kind_id,
                      :status, :closing_description)
      end
    end
  end
end

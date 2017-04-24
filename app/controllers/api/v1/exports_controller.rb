module Api
  module V1
    class ExportsController < ActionController::Base
      include JWTAuthorization
      include CanCan::ControllerAdditions

      # before_action :authenticate_request!

      rescue_from CanCan::AccessDenied, with: :render_access_denied
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

      def report
        # @report = Report.accessible_by(current_ability).find params[:id]
        @report = Report.find params[:id]

        # authorize! :read, @report
        render pdf: "#{@report.title}.pdf",
               template: 'api/v1/reports/show.pdf.haml',
               layout: 'pdf.html.haml',
               page_height: '1280px', page_width: '940px',
               show_as_html: params[:debug].present?
      end

      private

      def render_access_denied
        render json: { errors: 'Access denied' }, status: 403
      end

      def render_not_found
        render json: { errors: 'Record not found' }, status: 404
      end
    end
  end
end

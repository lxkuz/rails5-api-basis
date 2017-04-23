# frozen_string_literal: true
class ResourcesController < ApplicationController
  has_scope :order_by, default: 'created_at desc'

  before_action :authenticate_request!

  def show
    render json: serialize(resource).to_json
  end

  def index
    relation = collection
    relation = relation.page(params[:page]) if params[:page]
    render json: serialize(relation).to_json
  end

  def create
    record = resource_class.new resource_params
    authorize! :create, record
    if record.save
      render json: serialize(record).to_json
    else
      render json: serialize_errors(record).to_json, status: 406
    end
  end

  def update
    authorize! :update, resource
    if resource.update_attributes resource_params
      render json: serialize(resource).to_json
    else
      render json: serialize_errors(resource).to_json, status: 406
    end
  end

  def destroy
    authorize! :destroy, resource
    resource.destroy
    render json: serialize(resource).to_json
  end

  protected

  def serialize(record)
    serializer = "#{resource_class.name}Serializer".constantize
    if record.is_a?(Array) || record.is_a?(ActiveRecord::Relation)
      record.map { |r| serializer.new(r, scope: current_user) }
    else
      serializer.new(record, scope: current_user)
    end
  end

  def serialize_errors(record)
    ErrorSerializer.new(record)
  end

  def collection
    @collection ||= apply_scopes(resource_class.accessible_by(current_ability))
  end

  def resource_class
    @resource_class ||= params[:controller].split('/').last.singularize.camelize.constantize
  end

  def resource
    @resource ||= collection.find(params[:id])
  end

  def resource_params
    default_permitted_params = resource_class.column_names - %w(id updated_at created_at)
    params.permit(default_permitted_params)
  end
end

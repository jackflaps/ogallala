class EntitiesController < ApplicationController

  skip_before_action :authorize_request, only: [:index, :show]
  before_action :set_entity, only: [:show, :update, :destroy]

  # GET /entities
  def index
    @entities = Entity.all
    json_response(@entities)
  end

  # POST /entities
  def create
    @entity = Entity.create!(entity_params)
    json_response(@entity, :created)
  end

  # GET /entities/:id
  def show
    json_response(@entity)
  end

  # POST /entities/:id
  def update
    @entity.update!(entity_params)
    json_response(@entity)
  end

  # DELETE /entities/:id
  def destroy
    @entity.destroy
    json_response({"Deleted": @entity.id}, 200)
  end

  private

  def entity_params
    params.require(:entity).permit(
      :id, :entity_type, :bioghist, :legal_status, :cataloging_level, :record_status, :cataloging_language,
      names_attributes: [ :id, :name, :form, :_destroy ]
    )
  end

  def set_entity
    @entity = Entity.find(params[:id])
  end
end

class EntitiesController < ApplicationController

  before_action :require_login
  skip_before_action :require_login, only: [:index, :show]

  # GET /entities
  def index
    @entities = Entity.all
  end

  # GET /entities/new
  def new
    @entity = Entity.new
    @entity.names.build
  end

  # GET /entities/:id/edit
  def edit
    @entity = Entity.find(params[:id])
  end

  # GET /entities/:id
  def show
    @entity = Entity.find(params[:id])
  end

  # POST /entities
  def create
    @entity = Entity.new(entity_params)
    if @entity.save
      flash[:success] = "Created new entity"
      redirect_to :controller => :entities, :action => :edit, :id => @entity.id
    else
      flash[:error] = "Error: #{@entity.errors.messages}"
      redirect_to :controller => :entities, :action => :new
    end
  end

  # POST /entities/:id
  def update
    @entity = Entity.find(params[:id])
    if @entity.update_attributes(entity_params)
      flash[:success] = "Entity '#{@entity.authorized_name}' updated"
      redirect_to @entity
    else
      flash[:error] = "Error: #{@entity.errors.messages}"
      render :action => :edit
    end
  end

  # DELETE /entities/:id
  def delete
    @entity = Entity.find(params[:id])

    if @entity.destroy
      flash[:success] = "Entity '#{@entity.authorized_name}' deleted"
      redirect_to :controller => :entities, :action => :index
    else
      flash[:error] = "Error: #{@entity.errors.messages}"
      render :action => :edit
    end
  end

  private

  def entity_params
    params.require(:entity).permit(
      :entity_type,
      :bioghist,
      :legal_status,
      :cataloging_level,
      :record_status,
      names_attributes: [ :id, :name, :form, :_destroy ]
    )
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to manage entity records."
      redirect_to "/login"
    end
  end
end

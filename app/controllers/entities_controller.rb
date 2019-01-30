class EntitiesController < ApplicationController

  before_action :require_login
  skip_before_action :require_login, only: [:index, :show]

  def index
    @entities = Entity.all
  end

  def new
    @entity = Entity.new
    @entity.names.build
  end

  def edit
    @entity = Entity.find(params[:id])
  end

  def show
    @entity = Entity.find(params[:id])

    if @entity.nil?
      @entities = Entity.all
      flash.now[:error] = "Entity not found: /entities/#{params[:id]}"
      #redirect_to action: "index"
      render :action => "index"
    else
      respond_to do |format|
        format.html # render HTML view by default
        format.json { render json: @entity }
      end
    end
  end

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

  def update
    @entity = Entity.find(params[:id])
    if @entity.update_attributes(entity_params)
      flash[:success] = "Entity '#{@entity.authorized_name}' updated"
      redirect_to :controller => :entities, :action => :edit, :id => @entity.id
    else
      flash[:error] = "Error: #{@entity.errors.messages}"
      redirect_to :controller => :entities, :action => :edit, :id => @entity.id
    end
  end

  def delete
    @entity = Entity.find(params[:id])

    if @entity.destroy
      flash[:success] = "Entity '#{@entity.authorized_name}' deleted"
      redirect_to :controller => :entities, :action => :index
    else
      flash[:error] = "Error: #{@entity.errors.messages}"
      redirect_to :controller => :entities, :action => :edit, :id => @entity.id
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
      names_attributes: [ :id, :name, :form ]
    )
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to manage entity records."
      redirect_to "/login"
    end
  end
end

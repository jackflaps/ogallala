class EntitiesController < ApplicationController
  def index
    @entities = Entity.all
  end

  def show
    @entity = Entity.find_by(id: params[:id])

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
end

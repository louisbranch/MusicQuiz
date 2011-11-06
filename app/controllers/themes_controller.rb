class ThemesController < ApplicationController
  before_filter :authorize
  respond_to :html, :xml, :json
  
  def index
    @themes = Theme.all
  end
  
  def show
    @theme = Theme.find(params[:id])
    @tracks = @theme.tracks
  end
  
  def new
    @theme = Theme.new
  end
  
  def create
    @theme = Theme.new(params[:theme])
    if @theme.save
      flash[:notice] = 'Theme created!'
      respond_with(@theme, :location => themes_path)
    else
      redirect_to themes_path, :alert => 'An error has occured!'
    end
  end
  
  def edit
    @theme = Theme.find(params[:id])
  end
  
  def update
    @theme = Theme.find(params[:id])
    if @theme.update_attributes(params[:theme])
      flash[:notice] = 'Theme updated!'
      respond_with(@theme, :location => themes_path)
    else
      redirect_to themes_path, :alert => 'An error has occured!'
    end
  end
  
  def delete
    @theme = Theme.find(params[:id])
    if @theme.destroy
      flash[:notice] = 'Theme deleted!'
    else
      flash[:alert] = 'An error has occured!'
    end
    redirect_to themes_path
  end
  
end

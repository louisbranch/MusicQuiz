class TracksController < ApplicationController
  respond_to :html, :xml, :json
  
  def index
    @theme = Theme.find(params[:theme_id])
    @tracks = @theme.tracks
  end
  
  def show
    @theme = Theme.find(params[:theme_id])
    @track = @theme.tracks.find(params[:id])
  end
  
  def new
    @theme = Theme.find(params[:theme_id])
    @track = @theme.tracks.build
    @artists = Artist.all
  end
  
  def create
    @theme = Theme.find(params[:theme_id])
    @track = @theme.tracks.build(params[:track])
    if @track.save
      flash[:notice] = 'Track created!'
      respond_with(@track, :location => theme_path(@theme))
    else
      redirect_to theme_path(@theme), :error => 'An error has occured!'
    end
  end
  
  def edit
    @theme = Theme.find(params[:theme_id])
    @track = @theme.tracks.find(params[:id])
    @artists = Artist.all
  end
  
  def update
    @theme = Theme.find(params[:theme_id])
    @track = @theme.tracks.find(params[:id])
    if @track.update_attributes(params[:track])
      flash[:notice] = 'Track updated!'
      respond_with(@track, :location => theme_path(@theme))
    else
      redirect_to theme_path(@theme), :error => 'An error has occured!'
    end
  end
  
end

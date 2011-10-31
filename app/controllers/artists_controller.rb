class ArtistsController < ApplicationController
  respond_to :html, :xml, :json
  
  def index
    @artists = Artist.all
  end
  
  def show
    @artist = Artist.find(params[:id])
    @songs = @artist.songs
    @aliases = @artist.aliases
  end
  
  def new
    @artist = Artist.new
  end
  
  def create
    @artist = Artist.new(params[:artist])
    if @artist.save
      flash[:notice] = 'Artist created!'
      respond_with(@artist, :location => artists_path)
    else
      redirect_to artists_path, :alert => 'An error has occured!'
    end
  end
  
  def edit
    @artist = Artist.find(params[:id])
  end
  
  def update
    @artist = Artist.find(params[:id])
    if @artist.update_attributes(params[:artist])
      flash[:notice] = 'Artist updated!'
      respond_with(@artist, :location => artists_path)
    else
      redirect_to artists_path, :alert => 'An error has occured!'
    end
  end
  
  def delete
    @artist = Artist.find(params[:id])
    if @artist.destroy
      flash[:notice] = 'Artist deleted!'
    else
      flash[:alert] = 'An error has occured!'
    end
    redirect_to artists_path
  end
end

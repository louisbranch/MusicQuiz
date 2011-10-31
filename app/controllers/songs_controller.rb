class SongsController < ApplicationController
  respond_to :html, :xml, :json
  
  def index
    @artist = Artist.find(params[:artist_id])
    @songs = @artist.songs
  end
  
  def show
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.find(params[:id])
  end
  
  def new
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.build
  end
  
  def create
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.build(params[:song])
    if @song.save
      flash[:notice] = 'Song created!'
      respond_with(@song, :location => artist_path(@artist))
    else
      redirect_to artist_path(@artist), :error => 'An error has occured!'
    end
  end
  
  def edit
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.find(params[:id])
  end
  
  def update
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.find(params[:id])
    if @song.update_attributes(params[:song])
      flash[:notice] = 'Song updated!'
      respond_with(@song, :location => artist_path(@artist))
    else
      redirect_to artist_path(@artist), :error => 'An error has occured!'
    end
  end
end

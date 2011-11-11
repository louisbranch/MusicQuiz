class SongsController < ApplicationController
  before_filter :require_authentication
  before_filter :authorize, :except => :check
  respond_to :html, :xml, :json
  
  def index
    @songs = Song.all
  end
  
  def show
    @song = Song.find(params[:id])
    @aliases = @song.aliases
  end
  
  def new
    @song = Song.new
  end
  
  def create
    @song = Song.new(params[:song])
    if @song.save
      flash[:notice] = 'Song created!'
      respond_with(@song, :location => song_path(@song))
    else
      redirect_to songs_path, :error => 'An error has occured!'
    end
  end
  
  def edit
    @song = Song.find(params[:id])
  end
  
  def update
    @song = Song.find(params[:id])
    if @song.update_attributes(params[:song])
      flash[:notice] = 'Song updated!'
      respond_with(@song, :location => song_path(@song))
    else
      redirect_to song_path, :error => 'An error has occured!'
    end
  end
  
  def check
    song = Song.find(params[:id])
    aliases = song.aliases.collect{|p| p.name.downcase}
    aliases << song.name.downcase
    if aliases.include?(params[:name].downcase)
      render :text => "Right!", :status => '200'
    else
      render :text => 'Wrong!', :status => '404'
    end
  end
end

class AliasesController < ApplicationController
  before_filter :aliasable, :authorize
  
  def index
    @aliases = @aliasable.aliases
  end
  
  def new
    @alias = @aliasable.aliases.build
  end
  
  def create
    @alias = @aliasable.aliases.build(params[:alias])
    if @alias.save
      flash[:notice] = "Alias created!"
      redirect_to :id => nil
    else
      flash[:notice] = "An error has occured!"
      render :action => 'new'
    end
  end
  
  def edit
    @alias = @aliasable.aliases.find(params[:id])
  end
  
  def update
    @alias = @aliasable.aliases.find(params[:id])
    if @alias.update_attributes(params[:alias])
      flash[:notice] = "Alias edited!"
      redirect_to :id => nil
    else
      flash[:notice] = "An error has occured!"
      render :action => 'edit'
    end
  end
  
  def delete
    
  end
  
  protected
  
  def aliasable
    if params[:song_id]
      @aliasable = Song.find(params[:song_id])
    else
      @aliasable = Artist.find(params[:artist_id])
    end
  end
  
end

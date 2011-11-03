class ChallengesController < ApplicationController
  #before_filter :require_authentication
  
  def index
    @themes = Theme.all
    #@user = current_user
  end
  
  def new
    @theme = Theme.find(params[:theme_id])
    @tracks = @theme.tracks.sort_by{rand}
  end
  
end

class ChallengesController < ApplicationController
  before_filter :require_authentication
  respond_to :html, :xml, :json
  
  def index
    @themes = Theme.all
    @user = current_user
  end
  
  def new
    @user = current_user
    @theme = Theme.find(params[:theme_id])
    @challenge = @theme.challenges.build
    @tracks = @theme.tracks.sort_by{rand}
    @challenge.answers.build
  end
  
  def create
    @theme = Theme.find(params[:theme_id])
    @challenge = @theme.challenges.build(params[:challenge])
    @challenge.attributes = {'answer_ids' => []}.merge(params[:challenge] || {})
    if @challenge.save
      render :text => params  
    else
      render :text => "error"
    end
  
  end
  
end

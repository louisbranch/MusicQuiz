class ChallengesController < ApplicationController
  before_filter :require_authentication
  respond_to :html, :xml, :json
  
  def index
    @themes = Theme.all
    @user = current_user
  end
  
  def show
    @theme = Theme.find(params[:theme_id])
    @challenge = @theme.challenges.find(params[:id])
    @user = @challenge.user
    if @user != current_user
      redirect_to challenges_path, :error => 'Access denied!'
    end
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
    if @challenge.save && @challenge.create_score
      respond_with(@challenge, :location => theme_challenge_path(@theme,@challenge)) 
    else
      redirect_to challenges_path, :error => 'An error has occured!'
    end
  end
  
end

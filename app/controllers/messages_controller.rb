class MessagesController < ApplicationController
  def create
    user = User.find(params[:user_id])
    if user != current_user
      redirect_to challenges_path, :error => 'Access denied!'
    end
    challenge = Challenge.find(params[:challenge_id])
    send_message(user,challenge)
    redirect_to challenges_path, :notice => 'Score shared!'
  end
  
  private
  
  def send_message(user,challenge)
    user.profile.feed!(
      :picture => fb_thumbs_url,
      :link => fb_canvas_url,
      :name => "I scored #{challenge.score}% on the #{challenge.theme.name} Music Quiz",
      :caption => "Can you beat me?",
      :description => "MusicQuiz is a free Facebook application to test your music knowledge."
    )
  end
  
end

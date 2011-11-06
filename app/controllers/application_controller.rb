class ApplicationController < ActionController::Base
  include Authentication

  protect_from_forgery

  rescue_from FbGraph::Exception, :with => :fb_graph_exception

  def fb_graph_exception(e)
    flash[:error] = {
      :title   => e.class,
      :message => e.message
    }
    current_user.try(:destroy)
    redirect_to root_url
  end
  
  def fb_canvas_url
    'https://apps.facebook.com/musicquiz_mp/'
  end
  
  def fb_thumbs_url
    'http://www.google.com.br/images/srpr/logo3w.png'
  end
  
  helper_method :admin?
  
  protected
  def admin?
    current_user == User.first
  end  

  def authorize
    unless admin?
      flash[:error] = 'Unauthorized access'
      redirect_to root_path
      false
    end
  end
  
end

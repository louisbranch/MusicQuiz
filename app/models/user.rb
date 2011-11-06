class User < ActiveRecord::Base
  has_many :challenges, :dependent => :destroy
  has_many :themes, :through => :challenges, :uniq => true
    
  def profile
    @profile ||= FbGraph::User.me(self.access_token).fetch
  end
  
  def has_score?(theme)
    if challenges.where("theme_id = ?", theme).empty?
      false
    else
      true
    end
  end
  
  def best_score(theme)
    best = challenges.where("theme_id = ?", theme).first
    "#{best.score}%"
  end

  class << self
    extend ActiveSupport::Memoizable

    def config
      @config ||= if ENV['FB_APP_ID'] && ENV['FB_APP_SECRET'] && ENV['FB_SCOPE'] && ENV['FB_CANVAS_URL']
        {
          :client_id     => ENV['FB_APP_ID'],
          :client_secret => ENV['FB_APP_SECRET'],
          :scope         => ENV['FB_SCOPE'],
          :canvas_url    => ENV['FB_CANVAS_URL']
        }
      else
        YAML.load_file("#{Rails.root}/config/facebook.yml")[Rails.env].symbolize_keys
      end
    rescue Errno::ENOENT => e
      raise StandardError.new("config/facebook.yml could not be loaded.")
    end

    def app
      FbGraph::Application.new config[:client_id], :secret => config[:client_secret]
    end

    def auth(redirect_uri = nil)
      FbGraph::Auth.new config[:client_id], config[:client_secret], :redirect_uri => redirect_uri
    end

    def identify(fb_user)
      _fb_user_ = find_or_initialize_by_identifier(fb_user.identifier.try(:to_s))
      _fb_user_.access_token = fb_user.access_token.access_token
      _fb_user_.first_name = fb_user.first_name
      _fb_user_.last_name = fb_user.last_name
      _fb_user_.email = fb_user.email
      _fb_user_.save!
      _fb_user_
    end
  end
end

class Theme < ActiveRecord::Base
  has_many :tracks, :dependent => :destroy
  has_many :challenges, :dependent => :destroy
  has_many :users, :through => :challenges, :uniq => true 
  
  validates :name, :presence => true
  
  def avg_score
    challenges.average(:score).to_i
  end
  
end

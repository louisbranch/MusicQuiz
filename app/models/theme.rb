class Theme < ActiveRecord::Base
  has_many :tracks, :dependent => :destroy
  has_many :challenges, :dependent => :destroy
  
  validates :name, :presence => true
end

class Artist < ActiveRecord::Base
  has_many :songs, :dependent => :destroy
  has_many :aliases, :as => :aliasable, :dependent => :destroy
  has_many :answers, :as => :answerable, :dependent => :destroy
  
  validates :name, :presence => true
end

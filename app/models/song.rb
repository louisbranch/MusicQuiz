class Song < ActiveRecord::Base
  has_many :tracks
  has_many :themes, :through => :tracks
  belongs_to :artist
  has_many :aliases, :as => :aliasable, :dependent => :destroy
  has_many :answers, :as => :answerable, :dependent => :destroy
  
  validates :name, :presence => true
end

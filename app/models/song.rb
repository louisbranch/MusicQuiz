class Song < ActiveRecord::Base
  has_many :tracks
  has_many :themes, :through => :tracks
  belongs_to :artist
  
  validates :name, :presence => true
end

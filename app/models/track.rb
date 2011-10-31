class Track < ActiveRecord::Base
  belongs_to :theme
  belongs_to :song
  
end

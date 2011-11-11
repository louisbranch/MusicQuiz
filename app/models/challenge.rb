class Challenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :theme
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:name].blank? }
  
  default_scope order("score DESC")
  
  def create_score
    if !answers.empty?
      calculate_score  
    else
      self.score = 0
    end
    self.save!
  end
  
  private
  
  def calculate_score
    tracks_total
    correct_answers = (answers.where("correct = ?", true).count).to_f
    ratio = ((correct_answers/tracks_total.to_f)*100).round
    self.score = ratio
  end
  
  def tracks_total
    tracks = theme.tracks
    tracks_total = 0
    tracks.each do |track|
      if track.song.artist.nil?
        tracks_total = tracks_total + 1
      else
        tracks_total = tracks_total + 2
      end
    end
    tracks_total
  end
end

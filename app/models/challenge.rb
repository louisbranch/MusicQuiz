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
    tracks = ((theme.tracks.count)*2).to_f # Each track has one song and one artist
    correct_answers = (answers.where("correct = ?", true).count).to_f
    ratio = ((correct_answers/tracks)*100).round
    self.score = ratio
  end
  
end

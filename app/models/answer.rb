class Answer < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :answerable, :polymorphic => true
  before_save :validate_answer
  
  validates :name, :presence => true
  
  private
  
  def validate_answer
    aliases = answerable.aliases.collect{|p| p.name.downcase}
    aliases << answerable.name.downcase
    if aliases.include?(name.downcase)
      self.correct = true
    else
      self.correct = false
    end
    true
  end
end

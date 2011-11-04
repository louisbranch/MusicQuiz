class Answer < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :answerable, :polymorphic => true
  
  validates :name, :presence => true
end

class Alias < ActiveRecord::Base
  belongs_to :aliasable, :polymorphic => true
  
  validates :name, :presence => true
end

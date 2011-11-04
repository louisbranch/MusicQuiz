class Challenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :theme
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:name].blank? }
end

# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
include PublicActivity::Model
tracked owner: Proc.new{ |controller, model| controller && controller.current_user }
  
def self.search(search)
    where("name LIKE ?", "%#{search}%") 
  end
 has_many :articles

  validates :name, presence: true

  # default order when calling the Category model
  default_scope -> { order('created_at DESC') }
end

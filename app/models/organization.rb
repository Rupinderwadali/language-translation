# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organization < ActiveRecord::Base
  include PublicActivity::Model
tracked owner: Proc.new{ |controller, model| controller && controller.current_user }

  has_many :users
  has_many :countries

  validates :name, presence: true
end

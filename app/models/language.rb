# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class Language < ActiveRecord::Base
  def self.search(search)
    where("name iLIKE ?", "%#{search}%") 
  end
 
 has_many :articles, dependent: :destroy

  validates :name, presence: true
end

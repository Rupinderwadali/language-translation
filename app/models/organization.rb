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
  has_many :users
  has_many :countries

  validates :name, presence: true
  # add search feature
    def self.search(search)
    where("name iLIKE ?", "%#{search}%")
  end

end

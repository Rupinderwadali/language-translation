# == Schema Information
#
# Table name: installations
#
#  id           :integer          not null, primary key
#  installation :string(255)
#  email        :string(255)
#  address      :text
#  contact      :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Installation < ActiveRecord::Base
 has_many :sites , dependent: :destroy
 validates :installation, presence: true
end

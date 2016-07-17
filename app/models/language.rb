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
  has_many :articles, dependent: :destroy

  validates :name, presence: true
  def self.options_for_select
  order('LOWER(name)').map { |e| [e.name, e.id] }
end

end

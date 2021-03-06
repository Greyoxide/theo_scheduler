# == Schema Information
#
# Table name: notes
#
#  id           :bigint           not null, primary key
#  body         :text
#  notable_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  notable_id   :integer
#

class Note < ApplicationRecord
  belongs_to :notable, polymorphic: true

  validates :body, presence: true, uniqueness: true
end

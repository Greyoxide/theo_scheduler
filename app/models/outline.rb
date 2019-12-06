# == Schema Information
#
# Table name: outlines
#
#  id         :bigint           not null, primary key
#  number     :integer
#  status     :integer          default("active")
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Outline < ApplicationRecord

  def full_title
    "#{number} #{title}"
  end

  validates :number, numericality: true, presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true

  enum status: { active: 0, suspended: 1 }

  has_many :speaker_outlines
  has_many :speakers, through: :speaker_outlines
  has_many :notes, as: :notable

  default_scope { order(number: :asc) }
end

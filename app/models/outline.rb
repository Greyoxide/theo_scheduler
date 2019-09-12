class Outline < ApplicationRecord

  def full_title
    "#{number} #{title}"
  end

  has_many :speaker_outlines
  has_many :speakers, through: :outlines
  has_many :notes, as: :notable

  default_scope { order(number: :asc) }
end

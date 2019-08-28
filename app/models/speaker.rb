class Speaker < ApplicationRecord
  belongs_to :congregation
  has_many :speaker_outlines
  has_many :outlines, through: :speaker_outlines

  def full_name
    "#{first_name} #{last_name}".titleize
  end
end

class Speaker < ApplicationRecord
  belongs_to :congregation
  has_many :speaker_outlines
  has_many :outlines, through: :speaker_outlines

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def update_list(list)
  	self.speaker_outlines.delete_all
  	if list.first.class == String
  		list = list.split(',').map{ |o| o.to_i }
  	end
  	self.outlines << Outline.where(number: list)
  end
  
end

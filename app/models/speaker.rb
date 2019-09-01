class Speaker < ApplicationRecord
  belongs_to :congregation
  has_many :speaker_outlines
  has_many :outlines, through: :speaker_outlines

  after_save :update_outlines

  attribute :outline_list, :string

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def update_outlines
  	if outline_list
  		list = outline_list
  		self.speaker_outlines.delete_all
	  	if list.first.class == String
	  		if list.include?(",")
	  			list = list.split(',').map{ |o| o.to_i }
	  		elsif list.include(" ") and list.exclude? ","
	  			list = list.split(" ").map{ |o| o.to_i }
	  		end
	  	end
	  	self.outlines << Outline.where(number: list)
  	end
  end

  def update_list(list)
  	self.speaker_outlines.delete_all
  	if list.first.class == String
  		if list.include?(",")
  			list = list.split(',').map{ |o| o.to_i }
  		elsif list.include(" ") and list.exclude? ","
  			list = list.split(" ").map{ |o| o.to_i }
  		end
  	end
  	self.outlines << Outline.where(number: list)
  end

end

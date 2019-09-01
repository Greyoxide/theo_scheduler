class Speaker < ApplicationRecord
  belongs_to :congregation
  has_many :speaker_outlines
  has_many :outlines, through: :speaker_outlines

  validates_presence_of :first_name, :last_name

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
          # Assuming the list is a comma seperated list
	  			list = list.split(',').map{ |o| o.to_i }
	  		elsif list.include? " " and list.exclude? ","
          # In case they seperated outline numbers with a space and no comma
	  			list = list.split(" ").map{ |o| o.to_i }
        else
          # this assumes theres just a single talk outline
          list.split.map{|o| o.to_i}
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

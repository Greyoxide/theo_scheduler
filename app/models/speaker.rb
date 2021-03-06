# == Schema Information
#
# Table name: speakers
#
#  id              :bigint           not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  phone           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  congregation_id :integer
#

class Speaker < ApplicationRecord
  belongs_to :congregation
  has_many :speaker_outlines, dependent: :destroy
  has_many :outlines, through: :speaker_outlines
  has_many :talks
  has_many :notes, as: :notable

  validates_presence_of :first_name, :last_name

  after_save :update_outlines

  attribute :outline_list, :string

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def full_name=(name)
    split = name.split(' ', 2)
    self.first_name = split.first
    self.last_name = split.last
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

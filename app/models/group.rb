# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ApplicationRecord

  has_many :talks

  validates_presence_of :name

  before_save :strip_group

  def strip_group
    name.slice! " group"
    name.slice! " Group"
  end

  def full_name
    self.name.titleize + " Group"
  end

  def self.next_in_rotation
    list = self.joins(:talks).order("talks.date desc").uniq

    unless list.blank? or list.count < self.all.count
      list.last
    else
      self.all.last
    end
  end

end

class Congregation < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :home, uniqueness: true, allow_blank: true

  has_many :speakers, dependent: :destroy
  has_many :talks
  has_many :notes, as: :notable

  include Filterable

  before_save :strip_cong

  def strip_cong
    name.slice! " congregation"
    name.slice! " Congregation"
  end

  def full_name
    unless self.name.downcase.include? "congregation"
      "#{self.name.titleize} Congregation"
    else
      self.name.titleize
    end
  end

  def self.home
    where(home: true).first
  end
end

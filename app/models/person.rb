# == Schema Information
#
# Table name: people
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Person < ApplicationRecord

  has_many :assignments

  validates :first_name, :last_name, presence: true

  validate :must_be_unique_full_name

  def must_be_unique_full_name
    if Person.where(first_name: first_name).where(last_name: last_name).count > 0
      errors.add(:full_name, "#{full_name} already exists in the database.")
    end
  end

  def full_name
    "#{first_name} #{last_name}".titleize
  end

end

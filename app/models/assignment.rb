# == Schema Information
#
# Table name: assignments
#
#  id         :bigint           not null, primary key
#  date       :date
#  kind       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :bigint
#
# Indexes
#
#  index_assignments_on_person_id  (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_id => people.id)
#

class Assignment < ApplicationRecord
  belongs_to :person

  default_scope { order(:date) }

  enum kind: { chairman: 0, watchtower_reader: 1 }

  def self.find_within(start=nil, ending=nil)
    start = Date.today - 1.day if start.blank?
    ending = Date.today + 1.year if ending.blank?

    start = Date.parse(start) unless start.class.name == "Date"
    ending = Date.parse(ending) unless ending.class.name == "Date"

    where(date: start..ending)
  end

end

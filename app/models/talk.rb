# == Schema Information
#
# Table name: talks
#
#  id              :bigint           not null, primary key
#  date            :date
#  kind            :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  congregation_id :integer
#  group_id        :integer
#  outline_id      :bigint
#  speaker_id      :bigint
#
# Indexes
#
#  index_talks_on_outline_id  (outline_id)
#  index_talks_on_speaker_id  (speaker_id)
#
# Foreign Keys
#
#  fk_rails_...  (outline_id => outlines.id)
#  fk_rails_...  (speaker_id => speakers.id)
#

class Talk < ApplicationRecord
  belongs_to :speaker, optional: true
  belongs_to :outline, optional: true
  belongs_to :group, optional: true
  belongs_to :congregation, optional: true

  # Validations

  validate :incoming_talks_cannot_be_scheduled_on_same_date, :one_speaker_cannot_give_two_talks, :talks_cannot_be_scheduled_during_special_event, :cannot_schedule_the_same_incoming_talk_within_one_year

  default_scope { order(:date) }

  def incoming_talks_cannot_be_scheduled_on_same_date
    if self.incoming? and Talk.where(date: date).where(speaker: self.speaker).present?
      errors.add(:date, 'You cannot schedule two incoming talks on the same day.')
    end
  end

  def one_speaker_cannot_give_two_talks
    overlap = Talk.where(date: date).where(speaker_id: speaker_id)
    unless overlap.blank?
      errors.add(:date, "#{self.speaker.full_name} is already schedule for another talk on this day")
    end
  end

  def talks_cannot_be_scheduled_during_special_event
    if Talk.where.not(kind: 0).where(date: date).present?
      errors.add(:date, 'You cannot schedule talks during an assembly, convention, or other special event.')
    end
  end

  def cannot_schedule_the_same_incoming_talk_within_one_year
    t = Talk.normal.where(outline_id: self.outline_id).where("date >= ?", self.date - 1.year).last
    unless t.blank?
      errors.add(:date, "This outline is prevously scheduled #{ t.date.strftime('%D') }(#{ (self.date - t.date).to_i } days before). Please select a different outline or select any date after #{ t.date + 1.year  } ")
    end
  end

  # Attributes

  def self.incoming
    normal.where(congregation_id: nil)
  end

  def self.outgoing
    normal.where("congregation_id != ?", Congregation.home.id)
  end

  def incoming?
    self.congregation_id.blank? and normal?
  end

  def outgoing?
    self.congregation_id != Congregation.home.id and self.normal?
  end

  def special?
    true unless self.normal?
  end

  def self.find_within(start, ending)
    where(date: Date.parse(start.to_s)..Date.parse(ending.to_s))
  end

  def in_out_or_special
    if self.incoming?
      'Incoming'
    elsif self.outgoing?
      'Outoing'
    else
      'Special Event'
    end
  end

  def self.next_date
    talks = self.order(:date)

    unless talks.blank?
    talks.last.date + 7.days
    else
      Date.current
    end
  end

  enum kind: { normal: 0, assembly: 1, convention: 2, curcuit_overseer_visit: 3, special_talk: 4 }

end

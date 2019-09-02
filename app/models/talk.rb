class Talk < ApplicationRecord
  belongs_to :speaker, optional: true
  belongs_to :outline, optional: true
  belongs_to :group, optional: true
  belongs_to :congregation, optional: true

  validate :incoming_talks_cannot_be_scheduled_on_same_date, :one_speaker_cannot_give_two_talks, :talks_cannot_be_scheduled_during_assembly

  def self.incoming
    where(congregation_id: Congregation.home.id)
  end

  def self.outgoing
    where("congregation_id != ?", Congregation.home.id)
  end

  def incoming?
    self.congregation_id.blank?
  end

  def outgoing?
    self.congregation_id != Congregation.home.id
  end

  def self.find_within(start, ending)
    where(date: Date.parse(start.to_s)..Date.parse(ending.to_s))
  end

  def kind
    if self.incoming?
      'Incoming'
    else
      'Outoing'
    end
  end

  def self.assembly
    where(assembly: true)
  end

  def self.next_date
    talks = self.order(:date)

    unless talks.blank?
    talks.last.date + 7.days
    else
      Date.current
    end
  end

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

  def talks_cannot_be_scheduled_during_assembly
    if Talk.where(date: date).where(assembly: true).present?
      errors.add(:date, 'You cannot schedule talks during an assembly.')
    end
  end

end

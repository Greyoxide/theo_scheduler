# == Schema Information
#
# Table name: speaker_outlines
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  outline_id :bigint
#  speaker_id :bigint
#
# Indexes
#
#  index_speaker_outlines_on_outline_id  (outline_id)
#  index_speaker_outlines_on_speaker_id  (speaker_id)
#
# Foreign Keys
#
#  fk_rails_...  (outline_id => outlines.id)
#  fk_rails_...  (speaker_id => speakers.id)
#

class SpeakerOutline < ApplicationRecord
  belongs_to :speaker
  belongs_to :outline
end

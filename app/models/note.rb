class Note < ApplicationRecord
  belongs_to :notable, polymorphic: true

  validates :body, presence: true, uniqueness: true
end

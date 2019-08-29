class User < ApplicationRecord
  has_secure_password validations: false
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email, presence: true, uniqueness: true

  before_create :set_initial_security
  after_create :invite

  def set_initial_security
    generate_token(:secure_token)
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def invite
    # TODO Need to handle scenario where validations fail
    generate_token(:password_reset_token)
    generate_token(:secure_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.invite(self).deliver
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(:validate => false)
    UserMailer.password_reset(self).deliver
  end

end

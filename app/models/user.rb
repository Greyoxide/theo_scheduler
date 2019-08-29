class User < ApplicationRecord
  has_secure_password validations: false
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email, presence: true, uniqueness: true

  before_update :update_security, if: :password_digest_changed?
  before_create :set_initial_security
  # after_create :invite

  def set_initial_security
    generate_token(:secure_token)
  end

  def update_security
    # if the user changes the password then:
    # generate a new secure browsing token
    # nil out the password_reset_params so the password_reset/invitation email wont work again
    if self.password_digest_changed?
      generate_token(:secure_token)
      person.status = "active" if person.invited?
      password_reset_sent_at = nil
      password_reset_token = nil
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def invite
    # TODO Need to handle scenario where validations fail
    generate_token(:password_reset_token)
    generate_token(:crypto)
    self.password_reset_sent_at = Time.zone.now
    self.status = "Invited"
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

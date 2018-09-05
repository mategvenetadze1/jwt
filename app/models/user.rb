class User < ApplicationRecord
  before_save :downcase_email
  before_create :generate_confirmation_instructions

  has_secure_password
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: :false
  validates_format_of :email, with: /\A\S+@.+\.\S+\z/

  def downcase_email
    self.email = self.email.delete(' ').downcase
  end

  def generate_confirmation_instructions
    self.confirmation_token = SecureRandom.hex(5)
    file = File.open("data.txt", "w")
    file << self.confirmation_token
    file.close
    self.confirmation_sent_at = Time.now.utc
  end

  def confirmation_token_valid?
    (self.confirmation_sent_at + 30.days) > Time.now.utc
  end

  def mark_as_confirmed!
    self.confirmation_token = nil
    self.confirmed_at = Time.now.utc
    save
  end

  def confirmed_at?
    !!self.confirmed_at
  end
end

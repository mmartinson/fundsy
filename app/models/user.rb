class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, email_format: true

  before_save :capitalize_first_name

  def full_name
    if first_name || last_name
      return "#{first_name} #{last_name}".strip
    end
    email
  end

  private

  def capitalize_first_name
    self.first_name.capitalize!
  end

end

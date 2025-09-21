class ContactMessage < ApplicationRecord
  # enum status: { new: 0, read: 1, responded: 2 }

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :subject, presence: true
  validates :message, presence: true
end

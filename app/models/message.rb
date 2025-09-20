class Message < ApplicationRecord

  broadcasts_to ->(message) { "chat_#{message.chat_id}" }
  acts_as_message
  has_many_attached :attachments
end

class ContactMailer < ApplicationMailer
  def new_contact_message(contact_message_id)
    @contact_message = ContactMessage.find(contact_message_id)
    mail(to: 'tiagoantunes9991@gmail.com', subject: @contact_message.subject)
  end
end

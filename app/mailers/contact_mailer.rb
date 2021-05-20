class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to:  @contact.email, bcc: ENV['GMAIL_ADDRESS'], subject: '以下の内容でお問い合わせを受け付けました。'
    # mail to:  @contact.email, bcc: 'vulsry3125@gmail.com', subject: '以下の内容でお問い合わせを受け付けました。'
  end
end

class ContactMailer < ApplicationMailer
  default to: 'sssyb8@gmail.com', from: 'no-reply@example.com'

  def contact_email(contact_form)
    @contact_form = contact_form
    mail(subject: "お問い合わせ: #{@contact_form.subject}")
  end
end

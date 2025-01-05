class ContactMailer < ApplicationMailer
  default to: 'sssyb8@gmail.com'

  def contact_email(contact_form)
    @contact_form = contact_form
    # フォームで入力されたメールアドレスを送信元（from）に設定
    mail(from: @contact_form.email, subject: "お問い合わせ: #{@contact_form.subject}")
  end
end

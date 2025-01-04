class ContactsController < ApplicationController
  def create
    @contact_form = ContactForm.new(contact_params)

    if @contact_form.valid?
      # メール送信処理
      ContactMailer.contact_email(@contact_form).deliver_now

      flash[:notice] = "お問い合わせを送信しました"
      redirect_to root_path
    else
      flash.now[:alert] = "送信に失敗しました"
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact_form).permit(:name, :email, :subject, :message)
  end
end

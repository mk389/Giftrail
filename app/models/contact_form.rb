class ContactForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  
  attribute :name, :string
  attribute :email, :string
  attribute :subject, :string
  attribute :message, :string
  
  validates :name, presence: true
  
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "メールアドレスの形式が不正です" }
  validates :subject, presence: true
  validates :message, presence: true

  def submit
    if valid?
      # メール送信処理などをここで記述
      true
    else
      false
    end
  end
end  
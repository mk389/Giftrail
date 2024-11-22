class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_one_attached :icon

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "は有効なメールアドレスではありません" }
  validates :residence, presence: true
  validates :password, presence: true, length: { minimum: 6, message: "は6文字以上で入力してください" }

  private

  def password_confirmation_matches
    if password != password_confirmation
      errors.add("パスワードが一致しません")
    end
  end
end

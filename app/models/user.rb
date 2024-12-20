class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2],
         :confirmable

  has_many :posts, dependent: :destroy

  mount_uploader :icon, IconUploader

  validates :name, presence: true
  validates :residence, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.icon = auth.info.image
      user.password = Devise.friendly_token[0, 20]
      user.residence ||= '不明'

      user.skip_confirmation!

      if user.save
        user
      else
        user.errors.full_messages.each do |message|
          Rails.logger.error message
        end
        raise StandardError, "User could not be saved: #{user.errors.full_messages.join(", ")}"
      end
    end
  end
end

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
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.icon = auth.info.image
      user.residence ||= '不明'
      user.skip_confirmation!
    end
  end
end

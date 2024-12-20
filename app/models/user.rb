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
    user = find_by(provider: auth.provider, uid: auth.uid)

    if user
      user
    else
      user = find_by(email: auth.info.email)
      if user
        user.update(provider: auth.provider, uid: auth.uid)
        user
      else
        base_username = auth.info.name.parameterize
        unique_username = base_username
        counter = 1
        while User.exists?(username: unique_username)
          unique_username = "#{base_username}#{counter}"
          counter += 1
        end

        create(
          email: auth.info.email,
          username: unique_username,
          password: Devise.friendly_token[0, 20],
          provider: auth.provider,
          uid: auth.uid,
        )
      end
    end
  end
end

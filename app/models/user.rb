class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :posts, dependent: :destroy

  # アイコンのアップローダ
  mount_uploader :icon, IconUploader

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :residence, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { uid.present? }

  # OmniAuthからのユーザー取得または作成
  def self.from_omniauth(auth)
    # provider と uid でユーザーを検索
    user = find_by(provider: auth.provider, uid: auth.uid)

    if user
      # 既存のユーザーが見つかった場合、そのユーザーを返す
      user
    else
      # メールアドレスでユーザーを検索
      user = find_by(email: auth.info.email)

      if user
        # 既存ユーザーに provider と uid を関連付け
        user.update(provider: auth.provider, uid: auth.uid)
        user
      else
        # ユーザー名のユニーク性を確保
        base_username = auth.info.name.parameterize
        unique_username = base_username
        counter = 1

        # ユーザー名のユニーク性を確保するループ
        while User.exists?(username: unique_username)
          unique_username = "#{base_username}#{counter}"
          counter += 1
        end

        # 新規ユーザーを作成
        user = create(
          email: auth.info.email,
          name: unique_username,
          icon: auth.info.image,
          password: Devise.friendly_token[0, 20],
          provider: auth.provider,
          uid: auth.uid,
          residence: '不明'
        )

        # ユーザー作成後、保存に成功した場合のみ返す
        if user.persisted?
          user
        else
          # 作成に失敗した場合、エラーメッセージを追加して返す
          user.errors.add(:base, "ユーザー作成に失敗しました")
          nil
        end
      end
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end
end

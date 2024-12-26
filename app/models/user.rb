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
        # 新規ユーザーを作成
        base_name = auth.info.name
        unique_name = base_name
        counter = 1
  
        # nameのユニーク性を確保するループ
        while User.exists?(name: unique_name)  # ここをnameカラムを使用
          unique_name = "#{base_name}#{counter}"
          counter += 1
        end
  
        # 新規ユーザーを作成
        user = create(
          email: auth.info.email,
          name: unique_name,  # nameを使用
          icon: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'dummy2.jpg'), 'image/jpeg'),
          password: Devise.friendly_token[0, 20],
          provider: auth.provider,
          uid: auth.uid,
          residence: '不明'
        )
  
        # 保存に成功した場合のみユーザーを返す
        if user.persisted?
          user
        else
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

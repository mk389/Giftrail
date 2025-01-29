class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

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
          residence: '居住地不明'
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

  after_save :convert_icon_if_heic

  def self.create_unique_string
    SecureRandom.uuid
  end

  def convert_icon_if_heic
    return unless icon.present? && File.extname(icon.file.filename).downcase == ".heic"
  
    # CarrierWave でアップロードされたファイルを MiniMagick で変換
    image = MiniMagick::Image.open(icon.file.file)
    image.format "jpeg"
  
    # 元のファイルを置き換え
    temp_file = Tempfile.new(["converted", ".jpg"], binmode: true)
    image.write(temp_file.path)
  
    # CarrierWave に再アップロード
    self.icon = temp_file
    save!
  ensure
    temp_file.close! if temp_file
  end
end

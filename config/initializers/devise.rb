Devise.setup do |config|
  
   # Deviseから送信されるメールの送信元アドレスを設定
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  
  # Active RecordをORMとして使用することを指定
  require 'devise/orm/active_record'

  # メールアドレスをケースインセンシティブで扱う
  config.case_insensitive_keys = [:email]
  # メールアドレスの前後のホワイトスペースを自動で削除
  config.strip_whitespace_keys = [:email]
  # HTTP認証でのセッションストレージをスキップ
  config.skip_session_storage = [:http_auth]
  # パスワードのハッシュ処理の回数を設定（テスト環境では1回、他は12回）
  config.stretches = Rails.env.test? ? 1 : 12
  # メールアドレス変更時に確認が必要
  config.reconfirmable = true
  # サインアウト時にすべてのリメンバートークンを無効にする
  config.expire_all_remember_me_on_sign_out = true
  # パスワードの最小文字数を6文字、最大128文字に設定
  config.password_length = 6..128
  # メールアドレスの形式を検証するための正規表現
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  # パスワードリセットに使用するキーの有効期間を6時間に設定
  config.reset_password_within = 6.hours
  # サインアウトのHTTPメソッドをDELETEに設定
  config.sign_out_via = :get
  # エラーレスポンスのHTTPステータスを422 Unprocessable Entityに設定
  config.responder.error_status = :unprocessable_entity
  # リダイレクトのHTTPステータスを303 See Otherに設定
  config.responder.redirect_status = :see_other
end

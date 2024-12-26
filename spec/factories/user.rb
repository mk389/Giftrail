FactoryBot.define do
  factory :user do
    name { "John Doe" }
    residence { "Tokyo" }
    sequence(:email) { |n| "test#{n}@example.com" }  # emailを一意に生成
    password { "password123" }
    password_confirmation { "password123" }
    icon { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'dummy2.jpg'), 'image/jpeg') }

    provider { "google_oauth2" }
    uid { SecureRandom.uuid }  # 一意のUIDを生成
  end
end
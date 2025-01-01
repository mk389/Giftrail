FactoryBot.define do
  factory :user do
    name { "John Doe" }
    residence { "Tokyo" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
    provider { "google_oauth2" }
    uid { SecureRandom.uuid }
    icon { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'dummy2.jpg'), 'image/jpeg') }
  end
end
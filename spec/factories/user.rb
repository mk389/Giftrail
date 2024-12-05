# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { "John Doe" }
    residence { "Tokyo" }
    email { "test@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
    icon { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'dummy2.jpg'), 'image/jpeg') }
  end
end
  
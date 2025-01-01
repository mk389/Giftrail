FactoryBot.define do
  factory :post do
    title { 'Sample Post Title' }
    production_area { '東京都' }
    images { [Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'dummy2.jpg'), 'image/jpeg')] }
    association :user
  end
end
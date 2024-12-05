FactoryBot.define do
  factory :post do
    title { 'Sample Post Title' }
    production_area { '東京都' }
    association :user
  end
end
module LocationHelper
  def prefectures_and_countries
    combined = []

    # 日本の都道府県のリスト
    JAPAN_PREFECTURES.each do |prefecture|
      combined << { name: prefecture, type: 'prefecture' }
    end
  
    # 他の国々のリスト
    COUNTRIES.each do |country|
      combined << { name: country, type: 'country' }
    end

    combined
  end
end

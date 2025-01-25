module ApplicationHelper
  def default_meta_tags
    {
      site: 'Giftrail',
      title: 'お土産・手土産の情報を共有できるサービス',
      reverse: true,
      charset: 'utf-8',
      description: 'ユーザーが手土産・お土産の情報を投稿し、レビューを参考に、より良い商品を見つけることが出来ます。',
      keywords: '共有,お土産,手土産,国内,海外',
      canonical: Rails.env.production? ? "https://giftrail.net" : request.original_url, # 本番環境URL
      separator: '|',
      og: {
        site_name: 'Giftrail',
        title: 'お土産・手土産の情報を共有できるサービス',
        description: 'ユーザーが手土産・お土産の情報を投稿し、ユーザーがレビューを参考にすることができます。',
        type: 'website',
        url: Rails.env.production? ? "https://giftrail.net" : request.original_url, # 本番URL
        image: image_url('ogp.png'),
        locale: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        description: 'ユーザーが手土産・お土産の情報を投稿し、ユーザーがレビューを参考にすることができます。',
        image: image_url('ogp.png')
      }
    }
  end
end

module ApplicationHelper
  def default_meta_tags
    {
      site: 'Giftrail',
      title: 'お土産・手土産の情報を共有できるサービス',
      reverse: true,
      charset: 'utf-8',
      description: 'ユーザーが手土産・お土産の情報を投稿し、ユーザーがそのレビューを参考にすることができます。',
      keywords: '共有,お土産,手土産,国内,海外',
      canonical: Rails.env.production? ? request.original_url : 'https://giftrail.net', # 本番環境のみ正しいURLを設定
      separator: '|',
      og: {
        site_name: 'Giftrail',
        title: 'お土産・手土産の情報を共有できるサービス',
        description: 'ユーザーが手土産・お土産の情報を投稿し、ユーザーがそのレビューを参考にすることができます。',
        type: 'website',
        url: Rails.env.production? ? request.original_url : 'https://giftrail.net', # 本番環境用URL
        image: image_url('ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        image: image_url('ogp.png')
      }
    }
  end
end

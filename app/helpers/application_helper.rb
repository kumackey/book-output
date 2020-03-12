module ApplicationHelper
  def default_meta_tags
    {
      site: 'BookOutPut',
      title: '読書をクイズとしてアウトプットするサービス',
      reverse: false,
      charset: 'utf-8',
      description: '読書で得た知識をクイズにし、アウトプットしよう！',
      keywords: 'BookOutPut',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') }
      ],
      og: {
        site_name: 'BookOutPut',
        title: 'BookOutPut',
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('janbotron.jpg'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@kumackey_'
      }
    }
  end
end

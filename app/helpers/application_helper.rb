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

  def is_in_controllers_action?(controller_name, action_name)
    (controller.controller_name == controller_name && controller.action_name == action_name) ? true : false
  end
end

ActiveAdmin.register Book do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :googlebooksapi_id, :title, :author, :image, :description, :buy_link, :published_at
  #
  # or
  #
  permit_params do
    permitted = %i[googlebooksapi_id title author image description buy_link published_at]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
end

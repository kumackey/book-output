ActiveAdmin.register Question do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :content, :user_id, :book_id, :commentary, :answer_type
  #
  # or
  #
  permit_params do
    permitted = %i[content user_id book_id commentary answer_type]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
end

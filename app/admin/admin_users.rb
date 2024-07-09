ActiveAdmin.register AdminUser do
  role_changeable
  permit_params :email, :first_name, :last_name, :password, :password_confirmation, :role, :country, :state, :city

  filter :email
  filter :first_name
  filter :last_name
  filter :role
  filter :sign_in_count
  filter :created_at

  action_item :custom_action, only: :show do
    link_to 'Custom Action', '#'
  end

  index do
    selectable_column
    id_column
    column :full_name do |admin_user|
      "#{admin_user.first_name} #{admin_user.last_name}".strip
    end
    column :email
    column :role
    column :sign_in_count
    column :created_at
    actions default: true do |admin_user|
      item "Test", '#'
    end
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
      f.input :country, as: :select, collection: CS.countries.map { |code, name| [name, code] }, input_html: { id: 'admin_user_country' }
      f.input :state, as: :select, input_html: { id: 'admin_user_state' }
      f.input :city, as: :select, input_html: { id: 'admin_user_city' }
    end
    f.actions
  end

  # override the custom controller
  # controller do
  #   def create
  #     @admin_user = AdminUser.new(permitted_params[:admin_user])
  #     if @admin_user.save
  #       redirect_to admin_admin_users_path, notice: 'Admin user created successfully.'
  #     else
  #       render :new
  #     end
  #   end
  # end

  # create some custom action otherthen crud
  # for member routes
  # member_action :custom_action_name, method: :get do
  #   redirect_to admin_admin_users_path, notice: "Custom action performed for #{resource.email}"
  # end
  # endpoint is = GET /admin/admin_users/:id/custom_action_name

  # for collection
  # ActiveAdmin.register AdminUser do
  #   collection_action :custom_action_name, method: :get do
  #     # Example: Redirect to index page after custom action
  #     redirect_to admin_admin_users_path, notice: "Custom action performed for all admin users"
  #   end
  # end
  # endpoint is GET /admin/admin_users/custom_action_name
end

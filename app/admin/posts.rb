ActiveAdmin.register Post do
  config.per_page = 10
  # config.per_page = [1, 5, 10]

  permit_params :title, :description, :user_id, :read_count, :approved_by_admin

  filter :title, label: 'Something else'
  filter :title_or_description_cont, as: :string, label: "Name"
  filter :description
  filter :read_count
  filter :approved_by_admin, as: :check_boxes

  # as: :check_boxes
  # scope :unpublished
  # scope "Subcategories", :unpublished
  # scope("Approve") { |scope| scope.where(approved_by_admin: true) }
  # scope ->{ Date.today.strftime '%A' }, :unpublished


  index do
    selectable_column
    id_column
    column :title
    column :description
    column :user
    column :read_count
    column :approved_by_admin
    actions defaults: true do |post|
      item "Approve", approve_admin_post_path(post), method: :put if !post.approved_by_admin
      item "Unapprove", unapprove_admin_post_path(post), method: :put if post.approved_by_admin
    end
  end

  member_action :approve, method: :put do
    resource.update(approved_by_admin: true)
    redirect_to admin_posts_path, notice: "Post approved!"
  end

  member_action :unapprove, method: :put do
    resource.update(approved_by_admin: false)
    redirect_to admin_posts_path, notice: "Post unapproved!"
  end

  action_item :upload_csv, only: :index do
    link_to 'Upload CSV', action: 'upload_csv'
  end

  collection_action :upload_csv do
    render 'admin/posts/upload_csv'
  end

  collection_action :import_csv, method: :post do
    CsvImportService.new(params[:file]).call
    redirect_to collection_path, notice: "CSV imported successfully!"
  end

  # form do |f|
  #   f.inputs do
  #     f.input :user_id, input_html: { class: 'custom-form-input' }, label_html: { class: 'custom-form-label' }
  #     f.input :title, input_html: { class: 'custom-form-input' }, label_html: { class: 'custom-form-label' }
  #     f.input :description, input_html: { class: 'custom-form-input' }, label_html: { class: 'custom-form-label' }
  #     f.input :approved_by_admin, input_html: { class: 'custom-form-input' }, label_html: { class: 'custom-form-label' }
  #   end
  #   f.actions
  # end
end

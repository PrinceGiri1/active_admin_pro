require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe Admin::PostsController, type: :controller do
  include Devise::Test::ControllerHelpers
  render_views

  before(:each) do
    @admin = FactoryBot.create(:admin_user, email: 'admin@example.com')
	  @user = FactoryBot.create(:user)
	  @posts = FactoryBot.create_list(:post, 5, user: @user)
    sign_in @admin
  end

  describe 'GET #index' do
    it 'returns all admin post' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'returns a single admin post' do
      get :show, params: { id: @posts.last.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template('show')
    end
  end

  describe 'PUT #approve' do
	  it 'approves the post' do
	    post = @posts.first
	    put :approve, params: { id: post.id }
	    post.reload
	    expect(post.approved_by_admin).to be true
	    expect(response).to redirect_to(admin_posts_path)
	    expect(flash[:notice]).to eq('Post approved!')
	  end
	end

	describe 'PUT #unapprove' do
	  it 'unapproves the post' do
	    post = @posts.first
	    put :unapprove, params: { id: post.id }
	    post.reload
	    expect(post.approved_by_admin).to be false
	    expect(response).to redirect_to(admin_posts_path)
	    expect(flash[:notice]).to eq('Post unapproved!')
	  end
	end

	describe 'GET #upload_csv' do
	  it 'renders the upload CSV template' do
	    get :upload_csv
	    expect(response).to have_http_status(:success)
	    expect(response).to render_template('admin/posts/upload_csv')
	  end
	end

	# describe 'POST #import_csv' do
  #   it 'imports the CSV file and redirects to collection path' do
  #     csv_file = fixture_file_upload('files/sample.csv', 'text/csv')
  #     post :import_csv, params: { file: csv_file }
  #     expect(response).to redirect_to(collection_path)
  #     expect(flash[:notice]).to eq('CSV imported successfully!')
  #   end
  # end
end

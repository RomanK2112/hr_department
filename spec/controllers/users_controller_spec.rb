require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do

  let(:admin) { FactoryBot.create(:admin) }
  before(:each) do
    sign_in admin
  end

  describe 'GET #index' do
    context 'when admin log in ' do
      it 'renders index page' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'return list of all users' do
        user = controller.current_user
        get :index
        expect(assigns(:users)).to match_array([user])
      end
    end
  end

  describe 'GET #new' do
    it 'assings and new User to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid user params' do
      it 'creates new user' do
        expect {
          post :create, params: { user: FactoryBot.attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it 'redirects to admin path' do
        post :create, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to admin_admins_path
      end
    end

    context 'with invalid user params' do
      it 'does not save the new user in the database' do
        expect {
          post :create, params: { user: FactoryBot.attributes_for(:invalid_params) }
        }.to_not change(User, :count)
      end

      it 'redirects to new template' do
        post :create, params: { user: FactoryBot.attributes_for(:invalid_params) }
        expect(response).to redirect_to new_admin_user_path
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns requested user to @user' do
      user = FactoryBot.create(:user)
      get :edit, params: { id: user }
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the :edit template' do
      user = FactoryBot.create(:user)
      get :edit, params: { id: user }
      expect(response).to render_template(:edit)
    end
  end
end

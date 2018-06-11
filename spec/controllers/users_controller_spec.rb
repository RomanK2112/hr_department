require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do

  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user) }
  let(:back) { 'http://google.com' }

  before { request.env['HTTP_REFERER'] = back }

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

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'locates requested :user' do
        patch :update, params: { id: admin, user: FactoryBot.attributes_for(:admin) }
        expect(assigns(:user)).to eq(admin)
      end

      it 'changes @users attributes' do
        patch :update, params: { id: admin, user: FactoryBot.attributes_for(
          :admin, first_name: 'Serj', last_name: 'Lupus'
        )}
        admin.reload
        expect(admin.first_name).to eq('Serj')
        expect(admin.last_name).to eq('Lupus')
      end

      it 'redirects to the updated @user' do
        patch :update, params: { id: admin, user: FactoryBot.attributes_for(:admin) }
        expect(response).to redirect_to admin_user_path(admin)
      end
    end

    context 'with invalid email' do
      it 'gives flash danger message and re render edit' do
        user_params = FactoryBot.attributes_for(:admin, email: '123') 
        patch :update, params: { id: admin, user: FactoryBot.attributes_for(
          :admin, first_name: nil, last_name: nil, email: '123'
          ) }
        admin.update_attributes(user_params)
        expect(flash[:danger]).to eq(admin.errors.full_messages.to_sentence)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destoy' do
    context 'when user present' do
      it 'deletes the user and redirects to fallback location' do
        expect {
          delete :destroy, params: { id: admin }
        }.to change(User, :count).by(-1)
        expect(response).to redirect_to(back)
      end
    end

    context 'when user not present' do
      it 'throw activerecord error' do
        expect {
          delete :destroy, params: { id: '123' }
        }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end

  describe 'PUT #toggle_admin' do
    context 'when @user present' do
      it 'updates user to admin and redirects back' do
        put :toggle_admin, params: { id: user }
        expect(user.reload.is_admin).to be_truthy
        expect(response).to redirect_to(back)
      end

      it 'updates admin to user and redirects back' do
        put :toggle_admin, params: { id: admin }
        expect(admin.reload.is_admin).to be_falsey
        expect(response).to redirect_to(back)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }

  before(:each) do
    sign_in user
  end

  describe 'GET #index' do
    context 'with valid employee' do
      it 'renders index page' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'assigns user to @employee' do
        get :index, params: { id: user }
        expect(assigns(:employee)).to eq(user)
      end

      it 'return list of groups belongs to user' do
        get :index
        expect(assigns(:groups)).to eq(user.groups)
      end

      it 'should return filtered group' do
        get :index, params: { group: user.groups.first }
        expect(assigns(:groups)).to match_array([user.groups.first])
      end
    end
  end

  describe 'GET #edit' do
    it 'renders edit page' do
      get :edit, params: { id: user }
      expect(response).to render_template(:edit)
    end

    it 'assigns user to @employee' do
      get :edit, params: { id: user }
      expect(assigns(:employee)).to eq(user)
    end
  end

  describe 'GET #show_post' do
    it 'renders show_post page' do
      get :show_post, params: { id: post }
      expect(response).to render_template(:show_post)
    end

    it 'assings post to @post' do
      get :show_post, params: { id: post }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe 'PUT #update' do
    context 'when update email' do
      before do
        put :update, params: { id: user, user: { email: 'test@gmail.com'} }
      end

      it 'should assign user to @employee' do
        expect(assigns(:employee)).to eq(user)
      end

      it 'should update employee email' do
        expect(user.reload.email).to eq('test@gmail.com')
      end

      it 'should redirect to employees path' do
        expect(response).to redirect_to(employees_path)
      end
    end

    context 'when email not present' do
      before do
        put :update, params: { id: user, user: { email: nil } }
      end

      it 'should give rollback' do
        expect(user.reload.email).not_to be_nil
      end

      it 'assigns flash message to error' do
        expect(flash[:error]).to eq("You didn't update password")
      end

      it 'render again edit page' do
        expect(response).to render_template(:edit)
      end
    end
  end
end

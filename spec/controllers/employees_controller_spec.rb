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
end

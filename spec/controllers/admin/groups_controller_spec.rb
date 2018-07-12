require 'rails_helper'

RSpec.describe Admin::GroupsController, type: :controller do
  let(:admin) { create(:admin) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    before do
      get :index
    end

    it 'assings all groups to @groups' do
      expect(assigns(:groups)).to match_array(admin.groups)
    end

    it 'assigns all users to @users' do
      expect(assigns(:users)).to match_array([admin])
    end

    it 'render index template' do
      expect(response).to render_template(:index)
    end
  end
end

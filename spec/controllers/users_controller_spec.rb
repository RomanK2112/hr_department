require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  
  # let(:user) { FactoryBot.create(:user) }
  before(:each) do
    user = FactoryBot.create(:user)
    sign_in user
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
end

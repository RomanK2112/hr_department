require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  describe 'GET #index' do
    context 'with valid employee' do
      it 'renders index page' do
        get :index
        expect(response).to render_template(:index)
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

end
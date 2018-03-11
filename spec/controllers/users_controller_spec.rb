require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do

  before :each do
    user = FactoryBot.build(:user)
    sign_in(user)
  end

  let(:user) { FactoryBot.build(:user) }

  describe 'GET #index' do
    subject { get :index }
    before do
      5.times do
        FactoryBot.create(:user)
      end
      get :index
    end

    context 'when admin go to dashboard' do
      it 'return index page with all users' do
        # expect(subject).to render_template(:index)
        expect(assigns(:users)).to match(User.all)
      end
    end
  end
end

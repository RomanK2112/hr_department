require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  before :each do
    user = FactoryBot.create(:user)
    sign_in(user)
  end

  describe 'GET #index' do
    subject { get :index }
    before do
      5.times do
        FactoryBot.create(:user)
      end
    end

    context 'when admin go to dashboard' do
      let(:users) { User.all }
      it 'return index page with all users' do
        expect(subject).to render_template(:index)
        expect(:users).to match(User.all)
      end
    end
  end
end

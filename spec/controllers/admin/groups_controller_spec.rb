require 'rails_helper'

RSpec.describe Admin::GroupsController, type: :controller do
  let(:admin) { create(:admin) }
  let(:group) { create(:group) }

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

  describe 'GET #edit' do
    before do
      get :edit, params: { id: group }
    end

    it 'assings group to @group' do
      expect(assigns(:group)).to eq(group)
    end

    it 'render edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET #new' do
    before do
      get :new
    end

    it 'assigns new Group to @group' do
      expect(assigns(:group)).to be_a_new(Group)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, params: { id: group }
    end

    it 'assings requested group to @group' do
      expect(assigns(:group)).to eq(group)
    end

    it 'renders template edit' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'when @group save' do
      it 'saves new group in the database' do
        expect {
          post :create, params: { group: attributes_for(:group) }
        }.to change(Group, :count).by(1)
      end

      it 'redirects to admin_groups_path' do
        post :create, params: { group: attributes_for(:group) }
        expect(response).to redirect_to(admin_groups_path)
      end
    end

    context 'when @group name nil' do
      before do
        post :create, params: { group: { name: nil } }
      end

      it 'not save new group in the database' do
        expect(flash[:error]).to eq('Group was not saved!')
      end

      it 'renders new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST #add_member' do
    context 'when user present' do
      it 'assings requested group to @group' do
        post :add_member, params: { id: group, user: admin }
        expect(assigns(:group)).to eq(group)
      end
  
      it 'saves requested user to requested group' do
        expect {
          post :add_member, params: { id: group, user: admin }
        }.to change(group.users, :count).by(1)
      end
  
      it 'assings flash message to notice' do
        post :add_member, params: { id: group, user: admin }
        expect(flash[:notice]).to eq('You add new member')
      end
  
      it 'redirects to admin_groups_path' do
        post :add_member, params: { id: group, user: admin }
        expect(response).to redirect_to(admin_groups_path)
      end
    end

    context 'when user not present' do
      before do
        post :add_member, params: { id: group, user: nil }
      end

      it 'assings flash error message' do
        expect(flash[:error]).to eq('There is no user')
      end

      it 'redirects to admin_groups_path' do
        expect(response).to redirect_to(admin_groups_path)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      before do
        put :update, params: { id: group, group: attributes_for(:group, name: 'Test') }
      end

      it 'assings requested group to @group' do
        expect(assigns(:group)).to eq(group)
      end

      it 'updates name of requested group' do
        expect(group.reload.name).to eq('Test')
      end

      it 'redirects to admin_groups_path' do
        expect(response).to redirect_to(admin_groups_path)
      end
    end

    context 'with invalid params' do
      before do
        put :update, params: { id: group, group: attributes_for(:group, name: nil) }
      end

      it 'renders edit page again' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'assings requested group to @group' do
      delete :destroy, params: { id: group }
      expect(assigns(:group)).to eq(group)
    end

    it 'destroy requested group' do
      expect {
        delete :destroy, params: { id: group }
      }.to change(Group, :count).by(0)
    end

    it 'redirects to admin_groups_path' do
      delete :destroy, params: { id: group }
      expect(response).to redirect_to(admin_groups_path)
    end
  end
end

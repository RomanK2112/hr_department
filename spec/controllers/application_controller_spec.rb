require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def after_sign_in_path_for(resource)
      super resource
    end
  end

  let(:admin) { create(:admin) }
  let(:employee) { create(:user) }

  describe '#after_sign_in_path_for' do
    context 'when admin' do
      it 'redirects to admin path' do
        sign_in admin
        expect(controller.after_sign_in_path_for(admin)).to match '/admin/admins'
      end
    end

    context 'when employee' do
      it 'redirects to employee path' do
        sign_in employee
        expect(controller.after_sign_in_path_for(employee)).to match employees_path(employee.id)
      end
    end
  end  
end
module DeviseRequestSpecHelpers

  include Warden::Test::Helpers

  def sign_in(resource_or_scope, resource = nil)
    resource ||= resource_or_scope
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    if request.present?
      resource.update_tracked_fields!(request)
    else
      resource.current_sign_in_at = Time.now
      resource.save!
    end
    login_as(resource, scope: scope)
    resource.reload
    User.current_account = resource if resource.kind_of? User
  end

  def sign_out(resource_or_scope)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    logout(scope)
    User.current_account = nil if scope == :user
  end

end

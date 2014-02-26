class LoginPageExample < ::RailsConnector::Migration
  def up
    configuration_path = '/website/en/_configuration'

    login_page = create_obj(
      _path: "#{configuration_path}/login",
      _obj_class: 'LoginPage',
      headline: 'Log in'
    )

    reset_password_page = create_obj(
      _path: "#{configuration_path}/reset-password",
      _obj_class: 'ResetPasswordPage',
      headline: 'Reset Password'
    )

    attributes = get_obj_class('Homepage')['attributes']

    attributes << {
      name: 'login_page',
      type: :reference,
      title: 'Login Page',
    }

    attributes << {
      name: 'reset_password_page',
      type: :reference,
      title: 'Reset Password Page',
    }

    update_obj_class('Homepage', attributes: attributes)

    update_obj(
      Obj.find_by_path('/website/en').id,
      login_page: login_page['id'],
      reset_password_page: reset_password_page['id'],
    )
  end
end

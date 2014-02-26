class LoginPage < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'LoginPage',
      type: 'publication',
      title: 'Login',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
      ]
    )

    create_obj_class(
      name: 'ResetPasswordPage',
      type: 'publication',
      title: 'ResetPassword',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
      ]
    )
  end
end

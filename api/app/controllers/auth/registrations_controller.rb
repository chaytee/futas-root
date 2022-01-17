class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController

  private

  def sign_up_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
<<<<<<< HEAD
end
=======
end
>>>>>>> master

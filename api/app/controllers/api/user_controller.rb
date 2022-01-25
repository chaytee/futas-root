class Api::UserController < ApplicationController
  before_action :authenticate_user!

  include DeviseTokenAuth::Concerns::SetUserByToken
  #skip_before_action :verify_authenticity_token
  skip_before_action :method_name, raise: false
end
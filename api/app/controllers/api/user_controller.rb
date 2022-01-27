class Api::UserController < ApplicationController
  before_action :authenticate_user!, except: [:create, :index]

  include DeviseTokenAuth::Concerns::SetUserByToken
  #skip_before_action :verify_authenticity_token
  skip_before_action :method_name, raise: false

  def index
    render json: current_user
    # users = User.all
    # render json: users
  end
end
class Api::UserController < ApplicationController
  before_action :authenticate_user!, except: [:create, :index]

  include DeviseTokenAuth::Concerns::SetUserByToken
  #skip_before_action :verify_authenticity_token
  skip_before_action :method_name, raise: false

  def index
    #フロントに渡したいものgender
    render json: current_user.to_json(only: [:name, :gender])
  end


end
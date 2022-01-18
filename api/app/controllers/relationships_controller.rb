class RelationshipsController < ApplicationController
  before_action :create_invitation_digest, only: [:invitation_code]

  def invitation_code
  end

  def new
    @relationship = Relationship.new
  end

  def create
    to_user = User.find_by(email: params[:relationship][:email])
    @relationship = Relationship.new(name: params[:relationship][:name])

    # （１）パートナーのメールアドレスがDBに登録されていることを確認
    if to_user.nil?
      flash[:warning] = "そのメールアドレスのユーザーは登録されていません"
      redirect_to new_relationship_path
    # （２）パートナーがまだ相互フォローしていないことを確認
    elsif !to_user.no_relationship?
      flash[:danger] = "パートナーが既に他の方と家族登録しています"
      redirect_to new_relationship_path
    # （３）入力した招待コードをハッシュ化したものが、DBに保存されているパートナーのinvitation_digestと一致するかを確認
    elsif BCrypt::Password.new(to_user.invitation_digest).is_password?(params[:relationship][:invitation_code])

    else
      flash[:warning] = "招待コードが間違っています"
      redirect_to new_relationship_path
    end
  end

  private
    #招待コードをハッシュ化しでDB保存
    def create_invitation_digest
      current_user.invitation_token = User.new_token
      current_user.attributes = { invitation_digest: User.digest(current_user.invitation_token),
                                  invitation_made_at: Time.zone.now }
      current_user.save
      # current_user.save(context: :except_password_change)
      # context => modelにて"passwordのpresence: true" となっているバリデーションをskipする
    end
end

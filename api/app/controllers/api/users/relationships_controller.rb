class Api::Users::RelationshipsController < Api::UserController



  def create
    #raise current_user.relationship.inspect
    #relationship = Relationship.new(paircode_params, user_id: current_user.id)
    #has_oneのものをnewした意味と同じ.build_relationship
    #current_userに紐づいたものを取得できる
    case paircode_params[:pass_type]
    when 1
      #左はカラム名で右はpaircode_paramsのこと
      relationship = current_user.build_relationship(paircode: paircode_params[:paircode])
      #raise relationship.inspect

      if relationship.save
        render json: { success_message: '保存しました' }
      else
        render json: relationship.errors.full_messages
      end

    when 2
      #送信されたemailで探します
      partner = User.find_by(email: paircode_params[:partner_email])

      #送信されたものと一致していたら
      if partner.relationship.paircode == paircode_params[:paircode]
        current_user.relationship.create(partner.relationship)

       else
         render json: { '合言葉が違います'}
       end
    end


    #わざとエラー起こして中身見るraise current_user.inspect
    #同じ p current_user
    #p current_user
    #raise paircode_params.inspect

  end

  private

  def paircode_params
    #raise params.inspect
    #何を通すかの記述
    #params.require(:relationship).permit(:paircode).merge(user_id: current_user.id)
    #current_userは取得できているからそもそもmergeは不要
    params.require(:relationship).permit(:paircode, :pass_type, :partner_email)
  end



end

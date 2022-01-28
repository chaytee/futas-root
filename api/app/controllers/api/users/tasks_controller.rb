class Api::Users::TasksController < Api::UserController


  def index
    #raise current_user.inspect
    render json: current_user.relationship.tasks

    #これだと誰でも一覧見れる
    #render json: Task.all
  end

  def show
    #idでレコードそのものを取りたい時はfindでOK
    @task = Task.find(params[:id])

    #三項演算子で格納してrender jsonで返してもOK
    if @task.present?
      render json: @task
    else
      render json: { error_message: 'Not Found'}
    end
  end

  def create
    c = current_user.relationship.tasks.create(set_params)

    if c.present?
      render json: { success_message: '保存しました' }
    else
      render json: tasks.errors.messages
    end

  end

  def update

    c = current_user.relationship.tasks.update(set_params)

    if c.present?
      render json: { success_message: '保存しました' }
    else
      render json: tasks.errors.messages
    end

    # task = Task.find(params[:id])
    # if task.update(set_params)
    #   render json: { success_message: '更新しました' }
    # else
    #   render json: task.errors.messages
    # end
  end

  def destroy
    task = current_user.relationship.tasks.find(params[:id])

    # task = Task.find(params[:id])
    task.destroy
    render json: { success_message: '削除しました' }
  end

  # def set_user
  #   @gender = User.find(params[:id]).gender
  # end

  private
  def set_params
    #api通信の場合はテーブル名ではなくフロントで設定したオブジェクトparamsかtaskを指定?
    params.require(:task).permit(:title, :is_done, :limit_day, :limit_time)
  end

end

class Api::Users::TasksController < Api::UserController


  def index

    #render json: current_user.relationship.tasks.order(limit_day: :asc)

    #taskのidが取れてない
    # post = User.joins(relationship: :tasks).where(relationship_id: current_user.relationship_id).select('tasks.*', 'users.gender', 'users.name', 'users.id')

    #genderが欲しい
    post = Task.joins(relationship: :users).where(relationship_id: current_user.relationship_id).select('tasks.*', 'users.gender', 'users.name', 'users.id')
    render json: post.order(limit_day: :asc)

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
    task = current_user.tasks.new(relationship_id: current_user.relationship_id, title: set_params[:title], is_done: set_params[:is_done], limit_day: set_params[:limit_day], limit_time: set_params[:limit_time])

    if task.save
      render json: { success_message: '保存しました' }
    else
      render json: task.errors.messages
    end

  end

  def update

    task = current_user.tasks.find(params[:id])

    if task.update(set_params)
      render json: { success_message: '保存しました' }
    else
      render json: task.errors.messages
    end

  end

  def destroy
    # task = current_user.relationship.tasks.find(params[:id])
    task = current_user.tasks.find(params[:id])

    task.destroy
    render json: { success_message: '削除しました' }
  end

  private
  def set_params
    #api通信の場合はテーブル名ではなくフロントで設定したオブジェクトparamsかtaskを指定?
    params.require(:task).permit(:title, :is_done, :limit_day, :limit_time)
  end

end

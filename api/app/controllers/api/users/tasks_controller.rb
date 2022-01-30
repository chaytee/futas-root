class Api::Users::TasksController < Api::UserController


  def index
    render json: current_user.relationship.tasks.order(limit_day: :asc)

    # post = Task.left_joins(relationship: :users).where(relationship_id: current_user.relationship_id).select('tasks.*', 'users.gender', 'users.name')

    #taskのidが取れてない
    # post = User.joins(relationship: :tasks).where(relationship_id: current_user.relationship_id).select('tasks.*', 'users.gender', 'users.name', 'users.id')

    #これだとフロントでtask_idが見つからないということになる
    # post = Task.joins(relationship: :users).where(relationship_id: current_user.relationship_id).select('tasks.*', 'users.gender', 'users.name', 'users.id')
    # render json: post.order(limit_day: :asc)

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

    task = current_user.relationship.tasks.find(params[:id])

    if task.update(set_params)
      render json: { success_message: '保存しました' }
    else
      render json: task.errors.messages
    end

  end

  def destroy
    task = current_user.relationship.tasks.find(params[:id])

    task.destroy
    render json: { success_message: '削除しました' }
  end

  private
  def set_params
    #api通信の場合はテーブル名ではなくフロントで設定したオブジェクトparamsかtaskを指定?
    params.require(:task).permit(:title, :is_done, :limit_day, :limit_time)
  end

end

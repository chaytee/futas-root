class Api::Users::TasksController < Api::UserController


  def index

    #タスクが重複してダメだったもの
    # post = Task.joins(relationship: :users).where(relationship_id: current_user.relationship_id).select('tasks.*', 'users.gender', 'users.name', 'users.id')
    # render json: post.order(limit_day: :asc)

    #genderが欲しい joins関連性のないものをくっつけるincludes関連性があるものの意味合い
    #...現在以降
    relationship_task = Task.where(relationship_id: current_user.relationship_id).where(limit_day: Time.current... ).eager_load(:user).order(limit_day: :asc)
    # #as_json()の中を含んでjsonにするよ
    items_json = relationship_task.as_json(include: {user: {only: [:id, :name, :gender]}})
    # render json: items_json


    husband_tasks_count = Relationship.find(current_user.relationship.id).users.find_by(gender: 1).tasks.count
    wife_tasks_count = Relationship.find(current_user.relationship.id).users.find_by(gender: 2).tasks.count
    each_task_count = { husband: husband_tasks_count, wife: wife_tasks_count }.as_json
    #<< シフト演算 配列への追加
    request_json = items_json << each_task_count
    render json: request_json

  end

  def show
    #idでレコードそのものを取りたい時はfindでOK
    task = Task.where(relationship_id: current_user.relationship_id).find(params[:id])

    #三項演算子で格納してrender jsonで返してもOK
    if task.present?
      render json: task
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

    task = Task.where(relationship_id: current_user.relationship_id).find(params[:id])
    #task = current_user.tasks.find(params[:id])
    #task = current_user.tasks.new(relationship_id: current_user.relationship_id, title: set_params[:title], is_done: set_params[:is_done], limit_day: set_params[:limit_day], limit_time: set_params[:limit_time])

    if task.update(set_params)
      render json: { success_message: '保存しました' }
    else
      render json: task.errors.messages
    end

  end

  def destroy
    task = Task.where(relationship_id: current_user.relationship_id).find(params[:id])
    # task = current_user.relationship.tasks.find(params[:id])
    #task = current_user.tasks.find(params[:id])

    task.destroy
    render json: { success_message: '削除しました' }
  end

  private
  def set_params
    #api通信の場合はテーブル名ではなくフロントで設定したオブジェクトparamsかtaskを指定?
    params.require(:task).permit(:title, :is_done, :limit_day, :limit_time)
  end

end

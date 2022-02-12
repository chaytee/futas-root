//$store.state.modules.tasks.tasks
export const state = () => {
  return {
    tasks: [],
  };
};

export const getters = {
    allTasks(state) {
   return state.tasks
  }
  // tasks: state => state.tasks.map(task => {
  //   return {
  //     ...task,
  //     limit_d: task.limit_day,

  //   };
  // }),


};

export const mutations = {
  setTasks(state, tasks){
    state.tasks = tasks
  },
};

//commit()でミューテーションにデータを渡す
export const actions = {
  async getTasks({ commit }) {

    const res = await this.$axios.$get("/api/users/tasks")


    const now = this.$dayjs();

    this.husband = res.husband;
    this.wife = res.wife;

    //タスク情報の取得
    this.taskData = Array.from(res.tasks).filter((data) => {

      return (
        (data.is_done === 0 || data.is_done === null) &&
        this.$dayjs(data.limit_day)
      );
    });


    commit('setTasks', this.taskData);
  },



};

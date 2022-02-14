//$store.state.modules.tasks.tasks
const state = {
  tasks: [],
};

const getters = {
    allTasks(state) {
   return state.tasks
  }
  // vtasks: state => state.vtasks.map(vtask => {
  //   return {
  //     ...vtask,
  //     limit_d: vtask.limit_day,

  //   };
  // }),


};

const mutations = {
  setTasks(state, tasks){
    state.tasks = tasks
  },
};

//commit()でミューテーションにデータを渡す
const actions = {
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
export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
};

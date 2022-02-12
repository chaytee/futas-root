export const state = {
  tasks: [],
};

export const getters = {
  allTasks(state) {
   return state.tasks
  }
};

export const mutations = {
  setScore(state, {husband, wife}){
    // state.tasks = tasks
    state.tasks.husband = husband;
    state.tasks.wife = wife;
  }
};

export const actions = {
  async getScore({ commit }, {husband, wife}) {

    const res = await this.$axios.$get("/api/users/tasks")

    this.husband = res.husband;
    this.wife = res.wife;
    //複数の引数を渡せない


    commit('getScore', res);
  },

};

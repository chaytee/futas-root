export const state = {
  tasks: [],
};

export const getters = {
  allTasks(state) {
   return state.tasks
  }
};

export const mutations = {
  setTasks(state, tasks){
    state.tasks = tasks
  }
};

export const actions = {
  async fetchTasks({ commit }) {

    const response = await this.$axios.$get("/api/users/tasks")
    commit('fetchTasks', response);
  },

};

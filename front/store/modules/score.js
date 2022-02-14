const state = {

  husband: null,
  wife: null

};

const getters = {
  husbandScore: (state) => state.husband,
  wifeScore: (state) => state.wife
};

const mutations = {

  setHusbandScore(state, husband) {
    state.husband = husband
  },
  setWifeScore(state, wife) {
    state.wife = wife
  }
};


const actions = {

  async getScore({ commit }) {

    const res = await this.$axios.$get("/api/users/tasks")

    const husband = res.husband
    const wife = res.wife

    await commit('setHusbandScore', husband)
    await commit('setWifeScore', wife)


    console.log(res.husband)

  },

};
export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
};

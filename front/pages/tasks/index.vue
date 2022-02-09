<template>
  <div class="mission">
    <TotalScore :husband="this.husband" :wife="this.wife" />
    <h2 class="mb-2">Mission</h2>
    <Task v-for="task in taskData" :key="task.id" :task="task" />
    <TaskForm />
  </div>
</template>
<script>
// import {mapGetters, mapActions } from 'vuex';


import Task from "../../components/Task.vue";
import TaskForm from "../../components/TaskForm.vue";
import TotalScore from "../../components/TotalScore.vue";

export default {
  components: {
    Task,
    TaskForm,
    TotalScore
  },
  data() {
    return {
      taskData: [],
      genderData: '',
      taskCount:{},
      husband: 0,
      wife: 0,
    };
  },
  // computed: mapGetters(['allTasks']),
  // methods: {
  //   ...mapActions(['fetchTasks']),
  // },
  async created() {
    await this.$axios.$get("/api/users/tasks").then((res) => {

      // console.log(this.$store.state);

      const now = this.$dayjs();

      this.husband = res.husband;
      this.wife = res.wife;

      //タスク情報の取得
      this.taskData = Array.from(res.tasks).filter((data) => {

        // const limitDayDo  = this.$dayjs(data.limit_day) < now;

        // const yesterday = this.$dayjs().add(-1, "day");
        // console.log(yesterday);
        return (data.is_done === 0 || data.is_done === null) && this.$dayjs(data.limit_day)
        // > yesterday;
      });
    //  console.log(this.taskData);
    });
    // this.fetchTasks();
  },

}
</script>
<style lang="scss">
  .misson {
    padding: 20px 15px 40px;
  }
</style>

<template>
  <div class="misson">
    <h2>Mission</h2>
    <Task v-for="task in taskData" :key="task.id" :task="task" />
    <TaskForm />
  </div>
</template>
<script>
import Task from "../../components/Task.vue";
import TaskForm from "../../components/TaskForm.vue";

export default {
  components: {
    Task,
    TaskForm,
  },
  data() {
    return {
      initData: [],
      taskData: [],
      isDone: false,
    };
  },
  // async created() {
  //   await this.$axios.get("/tasks").then((res) => {
  //     this.taskData = res.data;
  //   });
  // },

  //未完了のものだけ表示
  // async created() {
  //   await this.$axios.get("/tasks?is_done=false").then((res) => {
  //     this.taskData = res.data;
  //   });
  // },
  //.filterでエラー？304
  async created() {
    await this.$axios.$get("/tasks").then((res) => {
      this.initData = res;
      this.taskData = Array.from(res).filter((data) => {
        return data.is_done === false;
      });
    });
  },

};
</script>
<style lang="scss">
  .misson {
    padding: 20px 15px 40px;
  }
</style>

<template>
  <div class="misson" v-bind:class="{ husband: isActive}">
    <TotalScore />
    <h2>Mission</h2>
    <Task v-for="task in taskData" :key="task.id" :task="task" />
    <TaskForm />
  </div>
</template>
<script>
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
      initData: [],
      taskData: [],
      isDone: '0',
      genderData: '',
      isActive: false,
    };
  },
  async created() {
    await this.$axios.$get("/api/users/tasks").then((res) => {
      console.log(res);
      //タスク情報の取得
      this.initData = res;
      this.taskData = Array.from(res).filter((data) => {
        return data.is_done === 0;
      });
    });
  },
  async mounted() {
    await this.$axios.$get("/api/user/?id").then((res)=> {
      this.genderData = res.gender;
      //性別が男だったらhusbandをつける
      if(this.genderData === 1 ) {
         return this.isActive = !this.isActive;
      }
    });
  },

}
</script>
<style lang="scss">
  .misson {
    padding: 20px 15px 40px;
  }
</style>

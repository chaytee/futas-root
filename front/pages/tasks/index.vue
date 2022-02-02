<template>
  <div class="mission" v-bind:class="{ husband: isActive }">
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
      taskData: [],
      genderData: '',
      isActive: false,
    };
  },
  async created() {
    await this.$axios.$get("/api/users/tasks").then((res) => {
      // console.log(res);
      //タスク情報の取得
      this.taskData = Array.from(res).filter((data) => {
        return data.is_done === 0 || data.is_done === null;
      });

    });
  },
  async mounted() {
    await this.$axios.$get("/api/user/?id").then((res)=> {
      // console.log(res.gender);
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

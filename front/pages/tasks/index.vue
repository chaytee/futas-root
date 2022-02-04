<template>
  <div class="mission" v-bind:class="{ husband: isActive }">
    <TotalScore :husband="this.husband" :wife="this.wife" />
    <h2>Mission</h2>
    <Task v-for="task in taskData" :key="task.id" :task="task" />
    <TaskForm />
  </div>
</template>
<script>
import Task from "../../components/Task.vue";
import TaskForm from "../../components/TaskForm.vue";
import TotalScore from "../../components/TotalScore.vue";

const dayjs = require('dayjs');
dayjs.extend(require('dayjs/plugin/timezone'));
dayjs.extend(require('dayjs/plugin/utc'));
dayjs.tz.setDefault('Asia/Tokyo');
dayjs.extend(require('dayjs/plugin/relativeTime'));

const now = dayjs();
const tomorrow = now.add(1, "day");


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
      taskCount:{},
      husband: 0,
      wife: 0,
    };
  },
  async created() {
    await this.$axios.$get("/api/users/tasks").then((res) => {

      this.husband = res.husband;
      this.wife = res.wife;

      //タスク情報の取得
      this.taskData = Array.from(res.tasks).filter((data) => {

        return (data.is_done === 0 || data.is_done === null) && dayjs(data.limit_day) > now;
      });
    // console.log(res);
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

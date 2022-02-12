<template>
  <div class="mission section-pt section-pb">
    <TotalScore :husband="this.husband" :wife="this.wife" />
    <h2 class="mb-2 section-title">Mission</h2>
    <div class="sq">
      <Task v-for="task in taskData" :key="task.id" :task="task" />
      <!-- <Task /> -->
    </div>
    <TaskForm />
    <!-- <p>{{ $store.state.modules.tasks.tasks }}</p> -->
    <!-- <ul>
      <li v-for="task in tasks" :key="task.id" >{{task.title}}</li>
    </ul> -->
    <!-- <p>{{tasks}}</p>
    <p>{{tasks}}</p> -->
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
    TotalScore,
  },
  data() {
    return {
      taskData: [],
      genderData: "",
      taskCount: {},
      husband: 0,
      wife: 0,
    };
  },
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
        return (
          (data.is_done === 0 || data.is_done === null) &&
          this.$dayjs(data.limit_day)
        );
        // > yesterday;
      });
      //  console.log(this.taskData);
    });
    // this.fetchTasks();
  },
};
</script>
<style lang="scss">
.mission {
  @include sm {
    .section-title {
      display: none;
    }
    .sq {
      margin-top: 15px;
      overflow-y: scroll;
      max-height: 432px;
    }
  }
}
</style>

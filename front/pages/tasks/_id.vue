<template>
<div>
  編集画面
  <!-- taskのidを子コンポーネントに渡す-->
  <TaskForm :task-id="$route.params.id" />
</div>
</template>
<script>
import TaskForm from "../../components/TaskForm";
export default {
  async asyncData({app, params}) {
    const url = `tasks/${params.id}`;
    const response =  await app.$axios.get(url);

    console.log(response);
    return
  },
  components: {
    TaskForm
  },
  data() {
    return {
      task: [],
    };
  },
};
</script>

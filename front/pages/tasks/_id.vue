<template>
<div>
  編集画面
  <!-- taskのidを子コンポーネントに渡す
  <todo-form :todo-id="$route.params.id" />-->
  <TaskForm :task-id="$route.params.id" />

</div>
</template>
<script>
import TaskForm from "../../components/TaskForm";
export default {
  components: {
    TaskForm
  },
};
</script>

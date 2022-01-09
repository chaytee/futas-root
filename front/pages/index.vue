<template>
  <div>
      <div class="columns">
        <!-- 1列目 -->
        <div class="column" style="background: #fee;">Column1</div>
        <!-- 2列目 -->
        <div class="column" style="background: #efe;">Column2</div>
        <!-- 3列目 -->
        <div class="column" style="background: #eef;">Column3</div>
      </div>
    <Task />
    <InputTask />
  </div>
</template>

<script>
import Task from '../components/Task.vue';
import InputTask from '../components/InputTask.vue';


export default {
  name: 'task',
  layout: 'default',
  components: { Task, InputTask },
}
</script>

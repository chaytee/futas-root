<template>
  <section class="container">
    <p>chatroom</p>
      <div class="columns">
        <!-- 1列目 -->
        <div class="column" style="background: #fee;">Column1</div>
        <!-- 2列目 -->
        <div class="column" style="background: #efe;">Column2</div>
        <!-- 3列目 -->
        <div class="column" style="background: #eef;">Column3</div>
      </div>
      <ChatWindow />
      <ChatForm />
  </section>
</template>

<script>
import Navbar from '../components/Navbar.vue';
import ChatWindow from '../components/ChatWindow .vue';
import ChatForm from '../components/ChatForm.vue';


export default {
  components: { Navbar, ChatWindow, ChatForm },
}
</script>

<template>
  <section class="container">
    <p>chatroom</p>
      <ChatWindow />
      <ChatForm />
  </section>
</template>

<script>
import ChatWindow from '../components/ChatWindow .vue';
import ChatForm from '../components/ChatForm.vue';


export default {
  components: { ChatWindow, ChatForm },
}
</script>

<template>
  <div>
      <div class="box">
        <invitationCode />
      </div>
      <hr>
      <div class="box">
        <invitationNew />
      </div>
  </div>
</template>

<script>
  import InvitationNew from '../../components/InvitationNew.vue';
  import InvitationCode from '../../components/InvitationCode.vue';

    export default {
    components: { InvitationCode, InvitationNew },
  }
    // function copyToClipboard() {
    //   var copyTarget = document.getElementById("copyTarget");
    //   copyTarget.select();
    //   //document.execCommand("Copy");
    //   alert('コピーしました');
    // }
</script>

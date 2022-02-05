<template>
  <div>
      <div v-if="!invitationShow" class="invitation" >
        <invitationCode />
      </div>
      <div v-if="invitationShow" class="invitation">
        <invitationNew />
      </div>
  </div>
</template>

<script>
  import InvitationNew from '../../components/InvitationNew.vue';
  import InvitationCode from '../../components/InvitationCode.vue';

    export default {
    components: { InvitationCode, InvitationNew },
    data() {
      return {
        invitationShow: true
      }
    },
    mounted() {
      if(this.$auth.user.relationship_id === null ){
          return this.invitationShow = !this.invitationShow;
      }
    }
  }
</script>

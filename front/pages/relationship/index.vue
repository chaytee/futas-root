<template>
  <div>
      <div v-if="!invitationShow" class="invitation" >
        <invitationCode />
        <div class="btn__wrap">
          <button class="swich-btn" v-on:click="swichBtn">パートナーが合言葉をすでに発行されている場合はこちら</button>
        </div>
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
    },
    methods: {
      swichBtn: function () {
        return this.invitationShow = !this.invitationShow;
      }
    }
  }
</script>
<style scoped lang="scss">
.swich-btn {
  font-size: 16px;
  background: none;
  border: none;
  text-decoration: underline;
  color: #EB0000;
}
</style>

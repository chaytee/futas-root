<template>
  <div class="navbar header columns" id="navbar">
    <h1 class="navbar-brand title">
      <img src="~/assets/img/logo.png" alt="futasu" /><span class="subtitle"
        >フータス</span
      >
    </h1>

    <div class="side">
      <div class="account__main columns">
        <p class="account__txt">こんにちは、<span class="name">{{ name }}</span>さん</p>
        <ul class="account__switch">
          <li><button class="btn" @click="logout">ログアウト</button></li>
          <li>
            <div class="error">{{ error }}</div>
          </li>
          <!-- <li>ログイン状態:{{ $auth.loggedIn }}</li> -->
        </ul>
      </div>
      <ul class="menu-list columns">
        <li class="column" v-bind:class="{menu_none : menuNone}">
          <nuxt-link to="/"><span class="menu_title">HOME</span></nuxt-link>
        </li>
        <li class="column" v-bind:class="{menu_none : menuNone}">
          <nuxt-link to="/chatroom"
            ><span class="menu_title">chatroom</span></nuxt-link
          >
        </li>
        <li class="column">
          <nuxt-link to="/relationship"
            ><span class="menu_title"
              ><span class="menu_title">Setting</span></span
            ></nuxt-link
          >
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
export default {

  data() {
    return {
      name: "",
      email: "",
      error: null,
      menuNone: false,
    };
  },
  methods: {
    async logout() {
      this.error = null;

      await this.$auth.logout().then(() => {
        localStorage.removeItem("access-token");
        localStorage.removeItem("client");
        localStorage.removeItem("uid");
        localStorage.removeItem("token-type");
      });
    },
  },
  mounted() {
    if (localStorage.uid) {
      this.name = localStorage.getItem('name');
    }
    if(this.$auth.user.relationship_id === null ){
        return this.menuNone= !this.menuNone;
    }
  },
};
</script>
<style lang="scss">
#navbar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  box-sizing: border-box;
  padding: 0 30px;
  height: 100px;
  background: #fffaca;
  justify-content: space-between;

  .navbar-brand.title {
    align-items: center;
    margin-bottom: 0;

    img {
      max-height: 60px;
    }
    .subtitle {
      margin-left: 20px;
    }
  }
  .side {
    align-self: center;

    .account__main {
      align-items: center;
      justify-content: flex-end;
    }

    .account__txt {
      font-size: 12px;
      margin-right: 20px;
      color: #999;
    }
    .account__switch {
      .btn {
        font-size: 12px;
        background: none;
        text-decoration: underline;
        border: none;
      }
    }
    .nuxt-link-exact-active  {
      color: #ccc;
    }
  }
  .menu-list {
    li.menu_none {
      display: none;
    }
  }
}
</style>

<template>
  <div
    class="navbar header columns"
    id="navbar"
    v-bind:class="{ 'nav-open': isHamburger }"
  >
    <h1 class="navbar-brand title">
      <img src="~/assets/img/logo.png" alt="futasu" /><span class="subtitle"
        >フータス</span
      >
    </h1>

    <div class="side">
      <div class="side__navi">
        <div class="account-main columns is-mobile">
          <p class="account-main__txt">
            こんにちは、<span class="name">{{ name }}</span
            >さん
          </p>
          <ul class="account-main__switch">
            <li><button class="btn" @click="logout">ログアウト</button></li>
            <li>
              <div class="error">{{ error }}</div>
            </li>
            <!-- <li>ログイン状態:{{ $auth.loggedIn }}</li> -->
          </ul>
        </div>
        <div class="global-menu">
          <ul class="menu-list columns is-mobile mb-0">
            <li class="column" v-bind:class="{ menu_none: menuNone }">
              <nuxt-link to="/"><span class="menu_title">HOME</span></nuxt-link>
            </li>
            <li class="column" v-bind:class="{ menu_none: menuNone }">
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
      <div class="hamburger" v-on:click="isHamburger = !isHamburger">
        <div class="hamburger__txt">menu</div>
        <span></span>
        <span></span>
        <span></span>
      </div>
      <div class="black-bg" v-on:click="isHamburger = !isHamburger"></div>
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
      isHamburger: false,
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
    clickHamburger: function () {
      return (this.isHamburger = !this.isHamburger);
    },
  },
  mounted() {
    if (localStorage.uid) {
      this.name = localStorage.getItem("name");
    }
    if (this.$auth.user.relationship_id === null) {
      return (this.menuNone = !this.menuNone);
    }
  },
};
</script>
<style lang="scss">
#navbar {
  position: fixed;
  top: 0;
  left: 0;
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  box-sizing: border-box;
  padding: 0 30px;
  height: 100px;
  background: #fffaca;
  margin: 0;

  @include ta {
    height: 55px;
    padding: 0 20px;
    padding-top: 3px;
    flex-flow: column;
    align-items: flex-start;
  }

  .navbar-brand.title {
    align-items: center;
    margin-bottom: 0;

    @include ta {
      height: 55px;
    }

    img {
      max-height: 60px;

      @include ta {
        max-height: 26px;
      }
    }
    .subtitle {
      margin-left: 20px;
      position: relative;
      top: 5px;

      @include ta {
        margin-left: 15px;
        font-size: 12px;
      }
    }
  }
}
.menu-list {
  display: none;
}
.hamburger {
  display: none;
  @include ta {
    position: fixed;
    top: 5px;
    right: 15px;
    display: block;
    width: 40px;
    height: 38px;
    box-sizing: border-box;
    text-align: center;

    span {
      position: absolute;
      left: calc(50% - 45%);
      width: 90%;
      height: 3px;
      background-color: #000;
      border-radius: 4px;
      display: inline-block;
      transition: all .5s;
      box-sizing: border-box;
      position: absolute;
      border-radius: 4px;
      z-index: 9999;
    }
    span:nth-of-type(1) {
      top: 14px;
    }
    span:nth-of-type(2) {
      top: 24px;
    }
    span:nth-of-type(3) {
      bottom: 0;
    }

    &__txt {
      font-size: 11px;
      position: fixed;
      top: 0;
      right: 20px;
    }
  }
}
.side {
  @include hp {
    display: flex;
    justify-content: center;
    flex-flow: column;
    height: 100px;
    box-sizing: border-box;
    padding-top: 10px;
  }
  &__navi {
    @include ta {
      position: fixed;
      left: -320px;
      top: 55px;
      width: 300px;
      height: 100vh;
      padding-top: 40px;
      background: linear-gradient(
        90deg,
        rgba(244, 172, 172, 1) 0.95%,
        rgba(215, 237, 234, 1) 100%
      );
      transition: all 0.6s;
      z-index: 200;
    }
    @include sm {
      width: 240px;
    }
  }

  .account-main {
    align-items: center;
    justify-content: flex-end;

    @include ta {
      display: none;
    }
    &__txt {
      font-size: 12px;
      margin-right: 20px;

      @include ta {
        margin-right: 0;
      }
    }

    &__switch {
      @include ta {
        margin-bottom: 10px;
      }
      .btn {
        font-size: 12px;
        background: none;
        text-decoration: underline;
        border: none;
      }
    }
  }

  .nuxt-link-exact-active {
    color: #999;
  }
  .black-bg {
    position: fixed;
    left: 0;
    top: 55px;
    width: 100vw;
    height: 100vh;
    z-index: 100;
    background-color: #666;
    opacity: 0;
    visibility: hidden;
    transition: all 0.6s;
    cursor: pointer;
    z-index: 2;
  }
}
@include ta {
  .nav-open {
    .side {
      &__navi {
        left: 0;
      }
    }
    .menu-list,
    .account-main {
      display: block;
      margin: 0;
    }
    .account-main {
      &__txt {
        text-align: center;
      }
    }

    .hamburger {
      span:nth-of-type(1) {
        transition-delay: 70ms;
        -webkit-transform: translateY(13px) rotate(-135deg);
        transform: translateY(13px) rotate(-135deg);
      }
      span:nth-of-type(2) {
        opacity: 0;
        -webkit-transform: translateX(-18px) scaleX(0);
        transform: translateX(18px) scaleX(0);
        transition-delay: 0s;
      }
      span:nth-of-type(3) {
        transition-delay: 140ms;
        -webkit-transform: translateY(-9px) rotate(135deg);
        transform: translateY(-9px) rotate(135deg);
      }
    }

    .black-bg {
      opacity: 0.8;
      visibility: visible;
    }
  }
}
</style>

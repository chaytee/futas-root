<template>
  <section id="welcome" class="hero">
    <div class="hero__bg">
      <div class="hero__wrap">
        <div class="hero__title cen">
          <img src="~/assets/img/title.png" alt="" />
        </div>
        <div class="box hero__box">
          <p class="cen">ようこそ！</p>
          <LoginForm @redirectToRelationship="redirectToRelationship" />
          <SignUp @redirectToRelationship="redirectToRelationship" />
        </div>
        <div class="hero__img cen">
          <img src="~/assets/img/title_img.png" alt="" />
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import LoginForm from "../components/LoginForm.vue";
import SignUp from "../components/SignUp.vue";

export default {
  layout: "welcomeType",
  components: { LoginForm, SignUp },
  data() {
    return {};
  },
  methods: {
    redirectToRelationship(){
        this.$router.push("/relationship");
    },
  }
};
</script>

<style lang="scss">
#welcome {
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;

  .hero__bg {
    position: relative;
    width: 100vw;
    height: 100%;
    top: 0;
    left: 50%;
    transform: translateX(-50%);
    box-sizing: border-box;
    display: flex;
    justify-content: center;
    align-items: flex-end;
    position: relative;
    &::before {
      content: "";
      width: 100%;
      height: 100%;
      position: absolute;
      top: 0;
      left: 0;
      z-index: 1;
      background: url(~@/assets/img/main_bg.jpg) no-repeat center top / cover;
    }
  }
  .hero__wrap {
    box-sizing: border-box;
    padding-top: 100px;
    max-height: 94%;
    max-width: 1220px;
    margin: 0 auto;
    align-self: flex-end;
    position: relative;
    z-index: 2;

    &::before {
      content: "";
      width: 100%;
      height: 100%;
      background-color: #fff;
      border-radius: 50% / 100% 100% 0 0;
      position: absolute;
      bottom: 0;
      left: 0;
      z-index: 2;
    }
  }
  .hero__title {
    margin-bottom: 20px;
    position: relative;
    z-index: 3;
    img {
      max-height: 150px;
    }
  }
  .hero__img {
    position: relative;
    z-index: 4;
  }
  .hero__box {
    width: 400px;
    margin: auto;
    position: relative;
    z-index: 5;
  }

  .change-form {
    font-size: 14px;
    margin-top: 20px;
  }
  .form-link {
    color: rgba(244, 172, 172, 1);

    &:hover {
      opacity: 0.9;
      text-decoration: underline;
    }
  }
}
</style>

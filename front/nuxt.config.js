export default {
  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    title: 'app',
    htmlAttrs: {
      lang: 'en'
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' },
      { name: 'format-detection', content: 'telephone=no' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },
  //authの設定
  auth: {
    redirect: {
      login: '/welcome', //middleware:authを設定したURLにアクセスがあった場合の、リダイレクト先。
      logout: '/welcome', //ログアウト後のリダイレクト先
      callback: false,
      home: '/tasks' ///ログイン後のリダイレクト先。
     },
    strategies: {
      local: {
        endpoints: {
          //ログイン処理に関する設定
          login: { url: '/api/auth/sign_in', method: 'post',propertyName: 'access_token'},
          //ログアウト処理に関する設定
          logout: { url: '/api/auth/sign_out', method: 'delete' },
          //ログイン時にユーザー情報を保存するか。
          user: false
         },
       }
     },
   },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [
    '@/assets/scss/base.scss',
    '@/assets/scss/common.scss'
  ],
  //変数を使用している
  styleResources: {
    scss: [
      '@/assets/scss/_variables.scss',
    ],
  },

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
    //  { src: '@/plugins/action-cable.js', mode: 'client' }
  ],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
  ],

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    // https://go.nuxtjs.dev/bootstrap
    '@nuxtjs/bulma',
    '@nuxtjs/axios',
    '@nuxtjs/style-resources',
    '@nuxtjs/auth'
  ],
  axios: {

    // APR_URL: "http://localhost:3000"
  },

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {
    loaders: {
          scss: {
            implementation: require('sass'),
          }
    }
  },

}

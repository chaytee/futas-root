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
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
      { rel: 'styleseet', href: 'https://fonts.googleapis.com/css2?family=M+PLUS+1p:wght@400;500;700&display=swap' }
    ]
  },
  router: {
    extendRoutes (routes, resolve) {
      routes.push(
        {
        name: 'index',
        path: '/',
        component: resolve(__dirname, 'pages/tasks/index.vue')
        },
        {
          name: 'task_id',
          path: '/api/users/tasks/:id',
          component: resolve(__dirname, 'pages/tasks/_id.vue')
        },


      )
    },
    //ログイン済み→/ 未ログイン→welcome
    middleware: ['auth']
  },
  //authの設定
  auth: {
    redirect: {
      login: '/welcome', //middleware:authを設定したURLにアクセスがあった場合の、リダイレクト先。
      logout: '/welcome', //ログアウト後のリダイレクト先
      callback: false,
      home: '/' ///ログイン後のリダイレクト先。
     },
    strategies: {
      local: {
        endpoints: {
          //ログイン処理に関する設定this.$auth.loginWith this.$auth.loggedIn
          login: { url: '/api/auth/sign_in', method: 'post',propertyName: 'access_token'},
          //ログアウト処理に関する設定
          logout: { url: '/api/auth/sign_out', method: 'delete' },
          //ログイン時にユーザー情報を保存するか。this.$auth.user
          //user: false,
          //使用しない時 user: false /this.$auth.user でuser情報を取得
          user: { url: '/api/user', method: 'get', propertyName:false }
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
  //SSRをサポートしないVueプラグインがあるためfalseへ
  plugins: [
    { src: '@/plugins/axios.js', ssr: false },
    //  { src: '@/plugins/action-cable.js', mode: 'client' }
    { src: '@/plugins/day.js',ssr: false},
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
    '@nuxtjs/auth',
    '@nuxtjs/fontawesome'
  ],
  axios: {
    // APR_URL: "http://localhost:3000"
  },
  fontawesome: {
    imports: [
      {
        set: '@fortawesome/free-solid-svg-icons',
        icons: ['fas'],
      },
    ],
  },

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {
    loaders: {
          scss: {
            implementation: require('sass'),
          }
    }
  },
  ssr: false,
  watchers: {
     webpack: {
       poll: true
      }
  }

}

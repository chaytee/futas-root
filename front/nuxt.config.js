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

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [
  ],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
  ],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
  ],

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    // https://go.nuxtjs.dev/bootstrap
    'bootstrap-vue/nuxt',
    '@nuxtjs/bulma',
    '@nuxtjs/axios',
    '@nuxtjs/proxy'

  ],
  axios: {
    proxy: true,

    // baseURL: "http://api:3000/",
    // browserBaseURL: "http://localhost:3000"
  },
  proxy: {

    //ログインのとき４０４エラーが出る
    '/auth': {
      target: 'http://localhost:3000',
      pathRewrite: {
        '^/auth': ''
      }

    }
  },

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {
    loaders: {
          scss: {
            implementation: require('sass'),
          }
    }
  },
  css: [
    { src: '~/assets/scss/base.scss'},
    { src: '~/assets/scss/common.scss' }
  ]
}

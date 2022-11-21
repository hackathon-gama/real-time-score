
window.onload = function () {
  Vue.use(Vuetify)
  vue = new Vue({
    el: '#app',
    vuetify: new Vuetify({
      theme: {
        dark: true
      }
    }),
    data: {
      matches: [],
      matchChannel: null,
      items: ['groups', 'final'],
      tab: 'groups',
    },
    methods: {
      onChangeTab (tab) {
        this.matches = []
        const oldMatchChannel = this.matchChannel

        this.subscribeInMatchChannel(this.items[tab])

        App.cable.subscriptions.remove(oldMatchChannel)
      },
      subscribeInMatchChannel (matchChannel) {
        this.matchChannel = App.cable.subscriptions.create(
          { channel: "MatchesChannel", stage: matchChannel },
          {
            received: function (matches) {
              vueContext.matches = matches
            }
          }
        )
      }
    },
    mounted () {
      vueContext = this
      this.subscribeInMatchChannel('groups')
    }
  })
}

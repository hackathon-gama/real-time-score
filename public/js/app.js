
window.onload = function () {
  vue = new Vue({
    el: '#app',
    data: {
      matches: [],
      matchChannel: null
    },
    mounted () {
      vueContext = this
      this.matchChannel = App.cable.subscriptions.create(
        { channel: "MatchesChannel", stage: 'groups' },
        {
          received: function (matches) {
            vueContext.matches = matches
          }
        }
      )
    }
  })
}

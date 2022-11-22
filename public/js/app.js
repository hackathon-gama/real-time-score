
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
      interactions: [],
      matchChannel: null,
      items: ['groups'],
      tab: 'groups',
      isShowingMatchCard: false,
      showingMatch: {},
      isAdmin: false,
      adminToken: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.ETUYUOkmfnWsWIvA8iBOkE2s1ZQ0V_zgnG_c4QRrhbg'
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
      },
      subscribeInInteractionsChannel (match_id) {
        this.matchChannel = App.cable.subscriptions.create(
          { channel: "InteractionsChannel", match_id },
          {
            received: function (interactions) {
              vueContext.interactions = vueContext.interactions.concat(interactions)
              const lastInteraction = vueContext.interactions[vueContext.interactions.length -1 ]

              if(lastInteraction) vueContext.showingMatch = lastInteraction.match
            }
          }
        )
      },
      onClickMatchCard (match) {
        App.cable.subscriptions.remove(this.matchChannel)
        this.subscribeInInteractionsChannel(match.id)
        this.showingMatch = match
        this.isShowingMatchCard = true
      },
      matchStatus (match) {
        return {
          pending: `Inicia em: ${match.match_date}`,
          running: 'Ao vivo',
          finished: `Finalizado em: ${match.updated_at}`
        }[match.status]
      },
      interactionType (interaction) {
        return {
          start: 'Inicia a partida',
          finish: 'Partida finalizada',
          goal: 'Gol',
          penalty: 'Penalti',
          fault: 'Falta',
          corner_kick: 'Escanteio'
        }[interaction.type]
      },
      interactionDescription (team_name, type) {
        return {
          start: 'Partida iniciada em Doha, vamos para mais 90 minutos emocionantes...',
          finish: 'Partida finalizada, muito boa partida, até aqui a melhora da copa.',
          goal: `Golaço para o ${team_name}`,
          penalty: `Penalidade máxima deu o juís, depois de conferir no vaarrrr... Vamos ver quem irá cobrar para ${team_name}`,
          fault: `Falta muito próxima da área em, é uma chance ótima para ${team_name}`,
          corner_kick: `Temos mais um escanteio para ${team_name}, vamos ver como será essa cobrança.`
        }[type]
      },
      createInteraction (match_id, team_id, team_name, type) {
        axios({
          method: 'post',
          headers: { Authorization: `Bearer ${this.adminToken}`},
          url: `http://localhost:3000/api/v1/matches/${match_id}/interactions?type=${type}`,
          data: {
            description: this.interactionDescription (team_name, type),
            time: 1,
            minutes: 23,
            team_id: team_id
          }
        });
      }
    },
    mounted () {
      vueContext = this
      this.subscribeInMatchChannel('groups')
      let queryString = window.location.search;
      let urlParams = new URLSearchParams(queryString);

      if( urlParams.has('user') ){
        this.isAdmin = urlParams.get('user') == 'admin'
      }
    }
  })
}

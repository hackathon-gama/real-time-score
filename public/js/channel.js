(function () {
  App.matchChannel = App.cable.subscriptions.create(
    { channel: "MatchChannel", match: $("#game-score").data("match-id") },
    {
      received: function (match) {
        $("#home_goals").html(match.home_goals);
        $("#away_goals").html(match.away_goals);
        $("#team_home").html(match.team_home);
        $("#team_away").html(match.team_away);
      },
    }
  );
}.call(this));

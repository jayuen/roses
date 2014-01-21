angular.module('rosesStandings.controllers').
  controller('StandingsCtrl', function($scope) {
    $scope.weeks = InitialStandingsData.weeks
    $scope.players = InitialStandingsData.players
    $scope.standings = InitialStandingsData.standings

    $scope.playerStandings = function(player, standings) {
      return _.sortBy(_.where(standings, {player_name: player.name}), function(standing) {
        return standing.week_name
      })
    }
  })

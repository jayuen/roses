var services = angular.module('roses.services', [])

services.factory('PicksRepo', ['$http', function($http) {
  return {
    save: function(pick) {
      var data = { pick: { rose: pick.rose} }
      if (pick.contestant) {
        data.pick.contestant_id = pick.contestant.id
      } 

      return $http.put('/picks/' + pick.id, data).then(function(result) {
        return result.data
      })
    }
  }
}])

services.factory('PlayersRepo', ['$http', function($http) {
  return {
    save: function(player) {
      var data = { player: { winner_id: player.winner.id} }

      return $http.put('/players/' + player.id, data).then(function(result) {
        return result.data
      })
    }
  }
}])

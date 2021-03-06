var services = angular.module('roses.services', [])
var adminServices = angular.module('rosesAdmin.services', [])

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

adminServices.factory('ContestantsRepo', ['$http', function($http) {
  return {
    save: function(contestant) {
      var data = { contestant: { eliminated: contestant.eliminated} }

      return $http.put('/contestants/' + contestant.id, data).then(function(result) {
        return result.data
      })
    }
  }
}])

adminServices.factory('WeeklyResultsRepo', ['$http', function($http) {
  return {
    save: function(weeklyResult) {
      var data = { weekly_result: { rose_order: weeklyResult.rose_order, contestant_id: weeklyResult.contestant.id, rose: weeklyResult.rose} }

      return $http.put('/weekly_results/' + weeklyResult.id, data).then(function(result) {
        return result.data
      })
    },

    computeScores: function(week) {
      var data = { week_id: week.id }
      return $http.post('/weekly_results/compute_scores', data).then(function(result) {
        return result.data
      })
    }
  }
}])

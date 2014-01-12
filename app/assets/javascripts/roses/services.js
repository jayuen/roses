var services = angular.module('roses.services', [])

services.factory('PicksRepo', ['$http', function($http) {
  return {
    save: function(pick) {
      return $http.put('/picks/' + pick.id, {pick: {contestant_id: pick.contestant.id, rose: pick.rose}}).then(function(result) {
        return result.data
      })
    }
  }
}])

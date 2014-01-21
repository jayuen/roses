angular.module('roses.controllers').
  controller('WeekCtrl', ['$scope', 'PicksRepo', function($scope, PicksRepo) {
    $scope.updatePick = function(pick) {
      PicksRepo.save(pick)
    }

    $scope.roseResult = function(week, pick) {
      var results = _.find($scope.weeks, function(w) {
        return w.id == week.id
      }).weekly_results

      var result = _.find(results, function(result) {
        if (result.contestant) return result.contestant.id == pick.contestant.id
      })

    if (result) 
      return result.rose
    else
      return false
    }

    $scope.picksForLockedWeek = function(weeklyEntry) {
      if (weeklyEntry == undefined) {
        return []
      } else {
        return _.sortBy(weeklyEntry.picks, function(pick) { return pick.rose_order})
      }
    }

    $scope.picksForWeek = function(weeklyEntry) {
      if (weeklyEntry === undefined) {
        return []
      } else {
        var picks = weeklyEntry.picks
        var sorted = _.sortBy(picks, function(pick) { return pick.rose_order })

        function matchContestant(pick, contestants){
          return _.find(contestants, function(contestant) {
            if (pick.contestant) {
              return pick.contestant.id === contestant.id   
            }
          })
        }

        _.each(sorted, function(pick) {
          match = matchContestant(pick, $scope.eligibleContestants)
          pick.contestant = match
        })
        return sorted
      }
    }
  }])

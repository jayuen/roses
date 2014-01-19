angular.module('roses.controllers').
  controller('WeekCtrl', ['$scope', 'PicksRepo', function($scope, PicksRepo) {
    $scope.updatePick = function(pick) {
      PicksRepo.save(pick)
    }

    $scope.roseResult = function(week, pick) {
      result = _.find(week.weekly_results, function(result) {
        return result.contestant.id == pick.contestant.id
      })

      return result.rose
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

angular.module('rosesAdmin.controllers').
  controller('WeeklyResultsCtrl', ['$scope', 'WeeklyResultsRepo', function($scope, WeeklyResultRepo) {
    $scope.eligibleContestants = InitialAdminData.eligibleContestants
    $scope.contestants = InitialAdminData.contestants
    $scope.weeklyResults = function(week) {
      if (week === undefined) {
        return []
      } else {

        function matchContestant(result, contestants){
          return _.find(contestants, function(contestant) {
            if (result.contestant) {
              return result.contestant.id === contestant.id   
            }
          })
        }

        var results = week.weekly_results
        var sorted = _.sortBy(results, function(result) { return result.rose_order })

        _.each(sorted, function(result) {
          match = matchContestant(result, $scope.contestants)
          result.contestant = match
        })
        return sorted
      }
    }

    $scope.updateResult = function(result) {
      WeeklyResultRepo.save(result)
    }

    $scope.computeScores = function(weeklyResult) {
      WeeklyResultRepo.computeScores(weeklyResult)
    }
  }])

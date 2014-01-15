angular.module('roses.controllers', []).
  controller('IndexCtrl', function($scope) {
    $scope.weeks = InitialData.weeks
    $scope.player = InitialData.player
    $scope.contestants = InitialData.contestants
    $scope.eligibleContestants = InitialData.eligibleContestants

    $scope.showWeek = function(week) {
      $scope.week = week
      $scope.show = 'week'
    }

    $scope.showWinnerPick = function() {
      $scope.show = 'winner'
    }
  }).  
  controller('PickWinnerCtrl', ['$scope', 'PlayersRepo', function($scope, PlayersRepo) {
    $scope.player.winner = _.find($scope.contestants, function(contestant) { return contestant.id == $scope.player.winner_id }) 

    $scope.updateWinnerPick = function() {
      PlayersRepo.save($scope.player)
    }
  }]).
  controller('WeekCtrl', ['$scope', 'PicksRepo', function($scope, PicksRepo) {
    $scope.updatePick = function(pick) {
      PicksRepo.save(pick)
    }

    $scope.picksForWeek = function(week) {
      if (week === undefined) {
        return []
      } else {
        var forWeek = _.filter($scope.player.picks, function(pick) { return pick.week_id == week.id})
        var sorted = _.sortBy(forWeek, function(pick) { return pick.rose_order })

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

angular.module('rosesAdmin.controllers', []).
  controller('AdminCtrl', ['$scope', 'ContestantsRepo', function($scope, ContestantRepo) {
    $scope.weeks = InitialAdminData.weeks

    $scope.updateContestant = function(contestant) {
      ContestantRepo.save(contestant)
    }

    $scope.showWeek = function(week) {
      $scope.week = week
      $scope.show = 'week'
    }

    $scope.showContestants = function() {
      $scope.show = 'contestants'
    }
  }]).
  controller('ContestantsCtrl', ['$scope', function($scope) {
    $scope.contestants = InitialAdminData.contestants
  }]).
  controller('WeeklyResultsCtrl', ['$scope', 'WeeklyResultsRepo', function($scope, WeeklyResultRepo) {
    $scope.eligibleContestants = InitialAdminData.eligibleContestants
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

        _.each(week.weekly_results, function(result) {
          match = matchContestant(result, $scope.eligibleContestants)
          result.contestant = match
        })
        return week.weekly_results
      }
    }

    $scope.updateResult = function(result) {
      WeeklyResultRepo.save(result)
    }
  }])

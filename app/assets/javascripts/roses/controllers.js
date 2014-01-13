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
  controller('PickWinnerCtrl', function($scope) {
    $scope.winner = _.find($scope.contestants, function(contestant) { return contestant.id == $scope.player.winner_id }) 

    $scope.updateWinnerPick = function(winner) {
      console.log(winner)
    }
  }).
  controller('WeekCtrl', ['$scope', 'PicksRepo', function($scope, PicksRepo) {
    $scope.updatePick = function(pick) {
      PicksRepo.save(pick)
    }

    $scope.picksForWeek = function(week) {
      if (week === undefined)
        return []
      else
        filtered = _.filter($scope.player.picks, function(pick) { return pick.week_id == week.id})
        return _.sortBy(filtered, function(pick) { return pick.rose_order })
    }
  }])

angular.module('roses.controllers').
  controller('IndexCtrl', function($scope) {
    $scope.season = InitialData.season
    $scope.weeks = InitialData.weeks
    $scope.player = InitialData.player
    $scope.contestants = InitialData.contestants
    $scope.eligibleContestants = InitialData.eligibleContestants

    $scope.showWeeklyEntry = function(weeklyEntry) {
      $scope.weeklyEntry = weeklyEntry
      $scope.show = 'week'
    }

    $scope.sortedWeeks = function(weeklyEntries) {
      return _.sortBy(weeklyEntries, function(weeklyEntry) {
        return weeklyEntry.week.name 
      })
    }

    $scope.showWinnerPick = function() {
      $scope.show = 'winner'
    }

    $scope.showStandings = function() {
      $scope.show = 'standings'
    }
  })  

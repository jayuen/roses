/*
var weeks = [
  {id: 1, name: 'Week of January 6th'},
  {id: 2, name: 'Week of January 13th'},
  {id: 3, name: 'Week of January 20th'},
  {id: 4, name: 'Week of January 27th'}
]

var contestants = [
  {id: 1, name: 'Andi'},
  {id: 2, name: 'Clare'},
  {id: 3, name: 'Chelsie'},
  {id: 4, name: 'Sharleen'}
]

var eligibleContestants = [
  {id: 1, name: 'Andi'},
  {id: 2, name: 'Clare'},
  {id: 3, name: 'Chelsie'}
]

var user = {
  winner_id: 2,
  picks: [
    {id: 1, week_id: 1, order: 1, contestant_id: 1, rose: true},
    {id: 2, week_id: 1, order: 2, contestant_id: 2, rose: true},
    {id: 3, week_id: 1, order: 3, contestant_id: 3, rose: false},
    {id: 4, week_id: 1, order: 4, contestant_id: 4, rose: false},
  ]
}

*/
angular.module('roses.controllers', []).
  controller('IndexCtrl', function($scope) {
    $scope.weeks = InitialData.weeks
    $scope.user = InitialData.user
    console.log($scope.user)
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
    $scope.winner = _.find($scope.contestants, function(contestant) { return contestant.id == $scope.user.winner_id }) 

    $scope.updateWinnerPick = function(winner) {
      console.log(winner)
    }
  }).
  controller('WeekCtrl', ['$scope', 'PicksRepo', function($scope, PicksRepo) {
    $scope.updatePick = function(pick) {
      PicksRepo.save(pick)
    }
  }])

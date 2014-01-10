var weeks = [
  {id: 1, name: 'Week of January 6th'},
  {id: 2, name: 'Week of January 13th'},
  {id: 3, name: 'Week of January 20th'},
  {id: 4, name: 'Week of January 27th'}
]

var contestants = [
  {id: 1, name: 'Andi'},
  {id: 2, name: 'Clare'},
  {id: 2, name: 'Chelsie'},
  {id: 2, name: 'Sharleen'}
]

var user = {
  winner_id: 2,
  picks: [
    {week_id: 1, contestant_id: 1, will_get_rose: true, rose: undefined},
    {week_id: 1, contestant_id: 2, will_get_rose: true, rose: undefined},
    {week_id: 1, contestant_id: 3, will_get_rose: false, rose: undefined},
    {week_id: 1, contestant_id: 4, will_get_rose: false, rose: undefined},
  ]
}

function IndexCtrl($scope) {
  $scope.weeks = weeks
  $scope.user = user
  $scope.contestants = contestants

  $scope.showWeek = function(week) {
    $scope.week = week
    $scope.show = 'week'
  }

  $scope.showWinnerPick = function() {
    $scope.winner = _.find($scope.contestants, function(contestant) { return contestant.id == $scope.user.winner_id }) 
    $scope.show = 'winner'
  }
}

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
    {id: 1, week_id: 1, order: 1, contestant_id: 1, will_get_rose: true, rose: undefined},
    {id: 2, week_id: 1, order: 2, contestant_id: 2, will_get_rose: true, rose: undefined},
    {id: 3, week_id: 1, order: 3, contestant_id: 3, will_get_rose: false, rose: undefined},
    {id: 4, week_id: 1, order: 4, contestant_id: 4, will_get_rose: false, rose: undefined},
  ]
}

function IndexCtrl($scope) {
  $scope.weeks = weeks
  $scope.user = user
  $scope.contestants = contestants
  $scope.eligibleContestants = eligibleContestants

  $scope.showWeek = function(week) {
    $scope.week = week
    $scope.show = 'week'
  }

  $scope.showWinnerPick = function() {
    $scope.show = 'winner'
  }
}

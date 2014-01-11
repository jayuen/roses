function PickWinnerCtrl($scope) {
  $scope.winner = _.find($scope.contestants, function(contestant) { return contestant.id == $scope.user.winner_id }) 

  $scope.updateWinnerPick = function(winner) {
    console.log(winner)
  }
}

angular.module('roses.controllers').
  controller('PickWinnerCtrl', ['$scope', 'PlayersRepo', function($scope, PlayersRepo) {
    $scope.player.winner = _.find($scope.contestants, function(contestant) { return contestant.id == $scope.player.winner_id }) 

    $scope.updateWinnerPick = function() {
      PlayersRepo.save($scope.player)
    }
  }])

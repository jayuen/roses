angular.module('rosesAdmin.controllers').
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
  }])

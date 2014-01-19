angular.module('rosesAdmin.controllers').
  controller('ContestantsCtrl', ['$scope', function($scope) {
    $scope.contestants = InitialAdminData.contestants
  }])

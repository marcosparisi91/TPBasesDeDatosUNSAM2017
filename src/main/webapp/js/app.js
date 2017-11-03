var myApp = angular.module("myApp",  ['ui.router']);
myApp.config(routes)

myApp.service('ComprasService', ComprasService)
myApp.controller("ComprasController", ComprasController )

myApp.controller('CargaController',CargaController)

var myApp = angular.module("myApp",  ['ui.router']);
myApp.config(routes)

myApp.service('ComprasService', ComprasService)
myApp.service('RequeridosService', RequeridosService)
myApp.controller("ComprasController", ComprasController )

myApp.controller('CargaController',CargaController)
myApp.controller("RequeridosController", RequeridosController )
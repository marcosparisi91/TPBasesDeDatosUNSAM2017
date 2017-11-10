const routes = ($stateProvider, $urlRouterProvider) => {
    
      $urlRouterProvider.otherwise("/compras")
    
      $stateProvider
    
        .state('Compras', {
          url: "/compras",
          templateUrl: "partials/Compras.html",
          controller: "ComprasController as comprasCtrl"
        })
        .state('CargaCompra', {
          url: "/CargaCompra/:id",
          templateUrl: "partials/CargaCompra.html",
          controller: "CargaController as cargaCtrl"
        })
        .state('Requeridos', {
          url: "/Requeridos",
          templateUrl: "partials/Requeridos.html",
          controller: "RequeridosController as requeridosCtrl"
        })
    }
    
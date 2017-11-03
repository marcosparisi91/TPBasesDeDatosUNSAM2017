class CargaController{
    constructor($stateParams, $state, ComprasService){
       this.ComprasService = ComprasService
       this.$stateParams = $stateParams
       this.articulos =  []
       this.findArticulosCompras()
        
    }

    findArticulosCompras(){
       this.ComprasService.findCompraPorId(this.$stateParams.id, (response)=>{
           
        this.articulos =_.map(response.data,ArticuloCompra.asArticuloCompra )
       })
    }

}
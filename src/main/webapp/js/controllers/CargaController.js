class CargaController{
    constructor($stateParams, $state, ComprasService){
       this.ComprasService = ComprasService
       this.$stateParams = $stateParams
       this.articulos =  []
       this.compra
       this.findArticulosCompras()
       this.findAtributosCompra()
       this.articulo=''
       this.cantidad = 0
            
    }

    findArticulosCompras(){
       this.ComprasService.findCompraPorId(this.$stateParams.id, (response)=>{
           this.articulos =_.map(response.data,ArticuloCompra.asArticuloCompra )
       })
    }


    findAtributosCompra(){
        this.ComprasService.findAtributosCompra(this.$stateParams.id,(response)=>{
            this.compra = angular.extend(new Compra(), response.data)
        })
      }

      insertarArticulo(){
        this.ComprasService.insertarArticulo(new ArticuloInsertar(this.$stateParams.id,this.articulo, this.cantidad),(response)=>
            {
                this.findArticulosCompras()
                this.articulo = ''
                this.cantidad=0
            })
          
      }
      cambioDescripcion(nuevoValor){
            if(nuevoValor != this.compra[0].descripcion){
                this.compra[0].descripcion=nuevoValor
                this.ComprasService.cambiarDescripcionCompra(this.compra[0],(response)=>{
            })
      }
    }
    eliminar(articulo){
        this.ComprasService.eliminarArticuloCompra(this.$stateParams.id,articulo,(response)=>{
            this.findArticulosCompras()
        })
    }
}
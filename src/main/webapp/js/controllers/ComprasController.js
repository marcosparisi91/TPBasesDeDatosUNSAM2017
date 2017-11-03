class ComprasController{
    
    constructor(ComprasService,$state){
        this.$state=$state
        this.ComprasService = ComprasService
        this.compras =[]
        this.findCompras()
    }
    
    findCompras(){
      this.ComprasService.findCompras((response)=>{
           this.compras =_.map(response.data,Compra.asCompra )
      })
    }

    insertarCompra(){
        this.ComprasService.insertarCompra((response)=>{
            this.$state.go('CargaCompra', {id: response.data})
       })
    }
  
}
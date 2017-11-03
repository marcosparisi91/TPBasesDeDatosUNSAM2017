class ComprasController{
    
    constructor(ComprasService){
        this.ComprasService = ComprasService
        this.compras =[]
        this.findCompras()
    }
    
    findCompras(){
      this.ComprasService.findCompras((response)=>{
           this.compras =_.map(response.data,Compra.asCompra )
      })
    }
  
}
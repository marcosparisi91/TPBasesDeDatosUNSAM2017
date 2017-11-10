class RequeridosController{
    constructor(RequeridosService){
        this.RequeridosService = RequeridosService
        this.articulos = []
        this.findRequeridos()
    }


    findRequeridos(){
        this.RequeridosService.findRequeridos( (response)=>{
            
            this.articulos = _.map(response.data, ArticuloRequerido.asArticuloRequerido)
           
        })
    }


    Exportar(){
       alert("Todavia no se exportar.")
    }

}
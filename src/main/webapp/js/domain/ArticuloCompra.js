class ArticuloCompra{
    constructor(){
        
    }

    static asArticuloCompra(jsonArticuloCompra) {
		return angular.extend(new ArticuloCompra(), jsonArticuloCompra)
  }

}

class ArticuloInsertar{
  constructor(idcompra, articulo, cantidad){
    this.idcompra=idcompra
    this.articulo=articulo
    this.cantidad = cantidad
  }
}
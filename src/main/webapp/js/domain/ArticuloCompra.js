class ArticuloCompra{
    constructor(){
        
    }

    static asArticuloCompra(jsonArticuloCompra) {
		return angular.extend(new ArticuloCompra(), jsonArticuloCompra)
  }

}
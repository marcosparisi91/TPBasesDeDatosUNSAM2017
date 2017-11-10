class ComprasService{
    constructor($http){
        this.$http = $http
        this.compras =[
            new Compra(1,"cositas","12/10/2017",[]),
            new Compra(2,"cosas","12/10/2017",[]),
            new Compra(3,"fin de mes","29/10/2017",[]),
            new Compra(4,"primero de mes","01/11/2017",[])
        ]
        
    }

    findCompras(callback){
        this.$http.get('http://localhost:9000/compras').then(callback)
    }
    findCompraPorId(id, callback){
        this.$http.get('http://localhost:9000/compras/articulos/'+ id).then(callback)
    }
    insertarCompra(callback){
        this.$http.put('http://localhost:9000/insertarCompra').then(callback)
    }
    findAtributosCompra(id,callback){
        this.$http.get('http://localhost:9000/compraAtributos/'+ id).then(callback)
    }
    insertarArticulo(articulo,callback){
        this.$http.put('http://localhost:9000/insertarArticulo/' + articulo.idcompra,articulo).then(callback)
    }
    cambiarDescripcionCompra(compra,callback){
        this.$http.put('http://localhost:9000/cambiarDescripcionCompra/' + compra.id ,compra).then(callback)
    }
    eliminarArticuloCompra(idcompra,articulo,callback){
        this.$http.put('http://localhost:9000/eliminarArticuloCompra/' + idcompra ,articulo).then(callback)
    }

}


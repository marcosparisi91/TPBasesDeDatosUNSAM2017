class ArticuloRequerido{
    constructor(){

    }
    static asArticuloRequerido(jsonArticulo){
        return angular.extend(new ArticuloRequerido(), jsonArticulo)
    }
}
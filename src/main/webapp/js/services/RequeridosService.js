class RequeridosService{
    constructor($http){
        this.$http= $http
    }

    findRequeridos(callback){
        this.$http.get('http://localhost:9000/requeridos').then(callback)
    }

}
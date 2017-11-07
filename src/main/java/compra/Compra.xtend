package compra

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Compra {
	
	var int idcompra
	var String fecha_hora
	var String descripcion
	
	new(){}
	
	new (int _idCompra, String fecha, String _descripcion){
		idcompra=_idCompra
		fecha_hora=fecha
		descripcion=_descripcion
	}
	
}
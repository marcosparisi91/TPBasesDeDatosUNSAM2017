package compra

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ArticuloCompra {
	
	int idarticulo
	String descripcion
	int cantidad_compra
	int categoria_idcategoria
	int unidad_idunidad 
	
	new(){}
	
	new (int _id, String _descripcion, int _cantidad, int _categoria, int _unidad){
		idarticulo=_id
		descripcion = _descripcion
		cantidad_compra = _cantidad
		categoria_idcategoria=_cantidad
		unidad_idunidad=_unidad
		
	}
}
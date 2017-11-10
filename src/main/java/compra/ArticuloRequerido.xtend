package compra

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ArticuloRequerido {
	int articulo_idarticulo
	int cantidad_aproximada
	String descripcion
	new (int _art, int cant, String desc){
		articulo_idarticulo = _art
		cantidad_aproximada = cant
		descripcion= desc
	}
}
package compra

import java.util.ArrayList
import java.util.Map
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat
import java.util.Calendar

@Controller
class CompraController {

	extension JSONUtils = new JSONUtils

	@Get("/compras")
	def Result compras() {
		try {
			DriverManager.registerDriver(new org.gjt.mm.mysql.Driver())
			var Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/heladera", "root",
				"1234");
			var Statement s = conexion.createStatement()
			var ResultSet rs = s.executeQuery("select * from compra");
			// order by idcompra desc limit 10
			var List<Compra> compras = new ArrayList<Compra>()

			while (rs.next()) {
				
				compras.add(new Compra(rs.getInt("idcompra"), rs.getString("fecha_hora"), rs.getString("descripcion")));
			}
			conexion.close();

			response.contentType = ContentType.APPLICATION_JSON
			ok(compras.toJson)
		} catch (Exception E) {
		}

	}

	
	
	@Get("/compras/articulos/:id")
	def Result compras() {
		try {
			
			DriverManager.registerDriver(new org.gjt.mm.mysql.Driver())
			var Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/heladera", "root",
				"1234");
			var Statement s = conexion.createStatement()
			var ResultSet rs = s.executeQuery("SELECT art.idarticulo, art.descripcion, art.categoria_idcategoria, art.unidad_idunidad, ahc.cantidad FROM articulo art left join articulo_has_compra ahc on art.idarticulo = ahc.articulo_idarticulo where ahc.compra_idcompra = '"+id+"'");
			var List<ArticuloCompra> itemCompra = new ArrayList<ArticuloCompra>()

			while (rs.next()) {
				
				itemCompra.add(new ArticuloCompra(rs.getInt("idarticulo"), rs.getString("descripcion"), rs.getInt("cantidad"), rs.getInt("categoria_idcategoria"), rs.getInt("unidad_idunidad")));
			}
			conexion.close();
		
			response.contentType = ContentType.APPLICATION_JSON
			ok(itemCompra.toJson)
			
		} catch (Exception E) {
		}

	}
	
	@Put("/insertarCompra")
	def Result insertarCompra(){
		try{
		DriverManager.registerDriver(new org.gjt.mm.mysql.Driver())
			var Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/heladera", "root",
				"1234");
			 var String fecha= new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime())
			var Statement s = conexion.createStatement()
			//
			
			s.executeUpdate("INSERT INTO compra (fecha_hora, descripcion) VALUES ('"+fecha+"', '');");
		
			 var ResultSet rs = s.executeQuery("SELECT LAST_INSERT_ID() as idcompra;") 
				var String idcompra
			while (rs.next()) {
				idcompra = rs.getString("idcompra")
			}
		
			conexion.close();
			response.contentType = ContentType.APPLICATION_JSON
			ok(idcompra.toJson)
			
		} catch (Exception E) {
			println(E.message)
			internalServerError(E.message)
		}
	}
	

	def static void main(String[] args) {
		XTRest.start(9000, CompraController)
	}
	

}

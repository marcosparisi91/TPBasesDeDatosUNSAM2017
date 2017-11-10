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
			var Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/heladera?useSSL=false", "root",
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

	@Get("/compraAtributos/:id")
	def Result compraAtributos() {
		try {
			
			DriverManager.registerDriver(new org.gjt.mm.mysql.Driver())
			var Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/heladera?useSSL=false", "root",
				"1234");
			var Statement s = conexion.createStatement()
			var ResultSet rs = s.executeQuery("select * from compra where idcompra = '"+id+"'");
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
			var Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/heladera?useSSL=false", "root",
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
			var Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/heladera?useSSL=false", "root",
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
	
	@Put("/insertarArticulo/:id")
	def Result insertarArticulo(@Body String body){
		
			
		try{
			var ArticuloInsert articulo = body.fromJson(ArticuloInsert)
			DriverManager.registerDriver(new org.gjt.mm.mysql.Driver())
			var Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/heladera?useSSL=false", "root",
				"1234");
			 
			var Statement s = conexion.createStatement()
			//
						
			var ResultSet rs = s.executeQuery("SELECT * from articulo where descripcion='"+articulo.articulo+"';") 
			var int size= 0;
			if (rs !== null)   
			{  
			  rs.beforeFirst();  
			  rs.last();  
			  size = rs.getRow();  
			  rs.beforeFirst()
			}  
		
			if (size!=0){
				rs.next()
				var int idart =rs.getInt("idarticulo")
				s.executeUpdate("update articulo set cantidad = cantidad + "+articulo.cantidad+" where idarticulo ='"+ idart +"' ;")
				s.executeUpdate("insert into articulo_has_compra Values('"+idart+"','"+id+"','"+ articulo.cantidad+"');")
			}else{
				s.executeUpdate("insert into articulo (descripcion, cantidad, categoria_idcategoria,unidad_idunidad) values ('"+articulo.articulo+"','"+articulo.cantidad+"','1','1');")
				 rs = s.executeQuery("SELECT LAST_INSERT_ID() as idarticuloinsert;") 
				 rs.next()
				var int idinsertado  = rs.getInt("idarticuloinsert")
				s.executeUpdate("insert into articulo_has_compra Values('"+idinsertado+"','"+id+"','"+ articulo.cantidad+"');")
			}
			 
			
		
			conexion.close();
			response.contentType = ContentType.APPLICATION_JSON
			ok()
			
		} catch (Exception E) {
			println(E.message)
			internalServerError(E.message)
		}
	}
	
	
	
	@Put("/cambiarDescripcionCompra/:id")
	def Result cambiarDescripcionCompra(@Body String body){
		
			
		try{
			var Compra compra = body.fromJson(Compra)
			DriverManager.registerDriver(new org.gjt.mm.mysql.Driver())
			var Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/heladera?useSSL=false", "root",
				"1234");
			 
			var Statement s = conexion.createStatement()
			s.executeUpdate("UPDATE compra SET descripcion ='"+ compra.descripcion  +"' WHERE idcompra='" + compra.idcompra + "'; ")
			conexion.close();
			response.contentType = ContentType.APPLICATION_JSON
			ok()
			
		} catch (Exception E) {
			println(E.message)
			internalServerError(E.message)
		}
	}
	
	@Put("/eliminarArticuloCompra/:id")
	def Result eliminarArticuloCompra(@Body String body){
		
			
		try{
			
			var ArticuloCompra articuloCompra = body.fromJson(ArticuloCompra)
			DriverManager.registerDriver(new org.gjt.mm.mysql.Driver())
			var Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/heladera?useSSL=false", "root",
				"1234");
			 
			var Statement s = conexion.createStatement()
			s.executeUpdate("update articulo set cantidad = cantidad - "+articuloCompra.cantidad_compra +" where idarticulo ='"+ articuloCompra.idarticulo +"' ;")
			s.executeUpdate("DELETE from articulo_has_compra WHERE articulo_idarticulo='"+articuloCompra.idarticulo+ "' AND compra_idcompra='"+id+"';")
			conexion.close();
			response.contentType = ContentType.APPLICATION_JSON
			ok()
			
		} catch (Exception E) {
			println(E.message)
			internalServerError(E.message)
		}
	}

	def static void main(String[] args) {
		XTRest.start(9000, CompraController)
	}
	
	
	@Get("/requeridos")
	def Result requeridos() {
		try {
			DriverManager.registerDriver(new org.gjt.mm.mysql.Driver())
			var Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/heladera?useSSL=false", "root",
				"1234");
			var Statement s = conexion.createStatement()
			var ResultSet rs = s.executeQuery("SELECT r.articulo_idarticulo, a.descripcion, r.cantidad_aproximada FROM requerido  r left join articulo a on r.articulo_idarticulo=a.idarticulo;");
			// order by idcompra desc limit 10
			var List<ArticuloRequerido> articulosRequeridos = new ArrayList<ArticuloRequerido>()

			while (rs.next()) {
				
				articulosRequeridos.add(new ArticuloRequerido(rs.getInt("articulo_idarticulo"), rs.getInt("cantidad_aproximada"), rs.getString("descripcion")));
			}
			conexion.close();

			response.contentType = ContentType.APPLICATION_JSON
			ok(articulosRequeridos.toJson)
		} catch (Exception E) {
		}

	}

}

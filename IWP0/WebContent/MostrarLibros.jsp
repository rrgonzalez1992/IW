<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.List"%>
<%@ page import="com.arquitecturajava.*"%>
<%! @SuppressWarnings("unchecked") %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Lista de Libros</title>
</head>
<body>
	<form action="ControladorLibros">
	<select name="categoria">
		<option value="seleccionar">seleccionar</option>
		<%
			List<String> listaDeCategorias=null;
		
		listaDeCategorias=(List<String>)request.getAttribute("listaDeCategorias");
		if(listaDeCategorias != null) System.out.println("no null");
		else System.out.println("Null");
		for(String categoria:listaDeCategorias) {
		if (categoria.equals(request.getParameter("categoria"))){
		%>
		<option value="<%=categoria%>" selected><%=categoria%></option>
		<%
			} else {
		%>
		<option value="<%=categoria%>"><%=categoria%></option>
		<%
			} }
		%>
	</select>
	<input type="submit" value="filtrar">
	<br />
	</form>
	<%
		List<Libro> listaDeLibros= null;
	listaDeLibros = (List<Libro>)request.getAttribute("listaDeLibros");
	for(Libro libro:listaDeLibros){
	%>
	<%=libro.getIsbn()%>
	<%=libro.getTitulo()%>
	<%=libro.getCategoria()%>
	<a href="BorrarLibro.jsp?isbn=<%=libro.getIsbn()%>">Borrar</a>
	<a href="FormularioEditarLibro.jsp?isbn=<%=libro.getIsbn()%>">Editar</a>
	<br />
	<%
		}
	%>
	<a href="FormularioInsertarLibro.jsp">Insertar Libro</a>
</body>
</html>
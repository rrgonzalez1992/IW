<%@ page import="java.util.List"%>
<%@page import="com.arquitecturajava.Libro"%>
<%
	Libro libro = Libro.buscarPorClave(request.getParameter("isbn"));
%>
<!-- cabecera y javascript omitido-->
<body>
	<form id="formularioEdicion" action="SalvarLibro.jsp">
		<fieldset>
			<legend>Formulario alta libro</legend>
			<p>
				<label for="isbn">ISBN:</label> <input type="text" id="isbn"
					name="isbn" value="<%=libro.getIsbn()%>" />
			</p>
			<p>
				<label for="titulo">Titulo:</label><input type="text" id="titulo"
					name="titulo" value="<%=libro.getTitulo()%>" />
			</p>
			<p>
				<label for="categoria">Categoria :</label> <select name="categoria">
					<%
						List<String> listaDeCategorias = null;
						listaDeCategorias = Libro.buscarTodasLasCategorias();
						for (String categoria : listaDeCategorias) {
							if (libro.getCategoria().equals(categoria)) {
					%>
					<option value="<%=categoria%>" selected="selected">
						<%=categoria%></option>
					<%
						} else {
					%>
					<option value="<%=categoria%>"><%=categoria%></option>
					<%
						}
						}
					%>
				</select> <br />
			</p>
			<p>
				<input type="submit" value="Salvar" />
			</p>
		</fieldset>
	</form>
</body>
</html>
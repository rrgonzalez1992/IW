package com.arquitecturajava.aplicacion;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class DataBaseHelper<T> {

	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://localhost/arquitecturajava";
	private static final String USUARIO = "root";
	private static final String CLAVE = "Luisfernando1";

	public int modificarRegistro(String consultaSQL) {

		Connection conexion = null;
		Statement sentencia = null;

		int filasAfectadas = 0;

		try {

			Class.forName(DRIVER);

			conexion = DriverManager.getConnection(URL, USUARIO, CLAVE);

			sentencia = conexion.createStatement();

			filasAfectadas = sentencia.executeUpdate(consultaSQL);

		} catch (ClassNotFoundException e) {
			throw new DataBaseException("Error de SQL", e);
		} catch (SQLException e) {

			throw new DataBaseException("Error de SQL", e);
		} finally {

			if (sentencia != null) {

				try {
					sentencia.close();
				} catch (SQLException e) {
					
				}

			}
			if (conexion != null) {

				try {
					conexion.close();
				} catch (SQLException e) {
				}
			}

		}

		return filasAfectadas;

	}

	@SuppressWarnings("unchecked")
	public List<T> seleccionarRegistros(String consultaSQL, Class<T> clase) {

		Connection conexion = null;
		Statement sentencia = null;
		ResultSet filas = null;
		ArrayList<T> listaDeObjetos = new ArrayList<T>();

		try {
			Class.forName(DRIVER);

			conexion = DriverManager.getConnection(URL, USUARIO, CLAVE);

			sentencia = conexion.createStatement();

			filas = sentencia.executeQuery(consultaSQL);

			while (filas.next()) {

				T objeto = (T)clase.newInstance();


				Method[] metodos = objeto.getClass().getDeclaredMethods();

				for (int i = 0; i < metodos.length; i++) {

					if (metodos[i].getName().startsWith("set")) {

						metodos[i].invoke(
								objeto,
								filas.getString(metodos[i].getName().substring(
										3)));
					}

					if (objeto.getClass().getName().equals("java.lang.String")) {

						objeto = (T) filas.getString(1);

					}

				}
				listaDeObjetos.add(objeto);
			}
		} catch (SecurityException e) {
			throw new DataBaseException("Error de seguridad", e);
		} catch (IllegalArgumentException e) {
			throw new DataBaseException("Error en el tipo de argumentos", e);

		} catch (ClassNotFoundException e) {

			throw new DataBaseException("Error no se encuentra la clase", e);

		} catch (SQLException e) {

			throw new DataBaseException("Error de SQL", e);
		} catch (InstantiationException e) {
			throw new DataBaseException("Error de Instanciacion", e);

		} catch (IllegalAccessException e) {
			throw new DataBaseException("Error de acceso", e);
		} catch (InvocationTargetException e) {
			throw new DataBaseException("Error de Invocacion", e);

		}

		return listaDeObjetos;

	}

}

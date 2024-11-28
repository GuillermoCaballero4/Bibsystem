<%-- 
    Document   : obtenerLibros
    Created on : 8 sept. 2024, 16:55:55
    Author     : david
--%>
<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    // Obtener los libros existentes desde la base de datos
    Statement st = conn.createStatement();
    ResultSet rs = st.executeQuery("SELECT idlibro, titulo_libro FROM libros");
    // Crear un arreglo JSON para almacenar los libros
    JSONArray libros = new JSONArray();
    while (rs.next()) {
        JSONObject libro = new JSONObject();
        libro.put("idlibro", rs.getInt("idlibro"));
        libro.put("titulo_libro", rs.getString("titulo_libro"));
        libros.put(libro);
    }
    // Devolver la respuesta JSON
    out.println(libros.toString());
%>

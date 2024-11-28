<%-- 
    Document   : consultar_autor
    Created on : 7 jun. 2024, 18:08:00
    Author     : david
--%>

<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%     try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT idautor, nombre_autor FROM autores");
%>
<option value="">Seleccionar Autor</option>
<%
    while (rs.next()) {
%>
<option value="<%= rs.getInt("idautor")%>"><%= rs.getString("nombre_autor")%></option>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

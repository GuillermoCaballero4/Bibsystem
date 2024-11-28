<%-- 
    Document   : consulta_usuario
    Created on : 25 jun. 2024, 19:24:59
    Author     : david
--%>

<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>


<%
    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT idusuario, nombre_usu FROM usuarios");
%>
<option value="">Seleccionar Usuario</option>
<%
        while (rs.next()) {
%>
<option value="<%= rs.getInt("idusuario")%>"><%= rs.getString("nombre_usu")%></option>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

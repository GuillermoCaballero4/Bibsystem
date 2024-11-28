<%-- 
    Document   : consultar_usuario
    Created on : 26 nov. 2024, 19:34:34
    Author     : david
--%>


<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%     try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT nombre_usu FROM usuarios");
%>
<option value="Todos los usuarios" >Todos los usuarios</option>
<%
    while (rs.next()) {
%>
<option value="<%= rs.getString("nombre_usu")%>"><%= rs.getString("nombre_usu")%></option>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>


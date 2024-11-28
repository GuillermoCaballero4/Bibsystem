<%-- 
    Document   : consultar_categoria
    Created on : 7 jun. 2024, 18:03:06
    Author     : david
--%>
<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT idcategoria, nombre_categoria FROM categorias");
%>
<option value="">Seleccionar Categoria</option>
<%
    while (rs.next()) {

%>
<option value="<%= rs.getInt("idcategoria")%>"><%= rs.getString("nombre_categoria")%></option>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<%-- 
    Document   : consulta_personal
    Created on : 6 jun. 2024, 17:43:26
    Author     : david
--%>
<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>


<%
    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT idpersonal, nombre_personal FROM personales");
%>
<option value="">Seleccionar Personal</option>
<%
        while (rs.next()) {
%>
<option value="<%= rs.getInt("idpersonal")%>"><%= rs.getString("nombre_personal")%></option>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

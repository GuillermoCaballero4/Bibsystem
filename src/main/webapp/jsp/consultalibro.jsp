<%-- 
    Document   : consultalibro
    Created on : 26 nov. 2024, 20:15:34
    Author     : david
--%>

<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%     try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT titulo_libro FROM libros");
%>
<option value="Todos los libros">Todos los libros</option>
<%
    while (rs.next()) {
%>
<option value="<%= rs.getString("titulo_libro")%>"><%= rs.getString("titulo_libro")%></option>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<%-- 
    Document   : conexion
    Created on : 16 abr. 2024, 18:11:29
    Author     : Administrador
--%>

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
    Connection conn = null;
    
    Class.forName("org.postgresql.Driver");
    conn= DriverManager.getConnection("jdbc:postgresql://localhost:5432/bibsystem","postgres","1");
    //if (conn != null){
    //out.print("conectadossss");
    //}
    
    
    
%>

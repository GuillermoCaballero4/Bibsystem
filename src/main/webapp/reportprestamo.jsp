<%-- 
    Document   : datocategoria
    Created on : 3 sept. 2024, 17:36:40
    Author     : david
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%-- 
    Document   : datopersonales
    Created on : 3 sept. 2024, 17:18:16
    Author     : david
--%>

<%@ page import="net.sf.jasperreports.engine.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="net.sf.jasperreports.engine.util.*" %>
<%@ include file="jsp/conexion.jsp" %>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%    try {
        /*INDICAMOS EL LUGAR DONDE SE ENCUENTRA NUESTRO ARCHIVO JASPER*/
        File reportFile = new File(application.getRealPath("reportes/informeprestamos.jasper"));
        /**/
        Map parametros = new HashMap();
  String idfechaa = request.getParameter("idfechaa");
String idfechab = request.getParameter("idfechab");
String codigo = request.getParameter("e");
String nombre_usu = request.getParameter("nombre_usu");

// Comprobar si las fechas no son nulas y convertirlas directamente a java.sql.Date
if (idfechaa != null && idfechab != null) {
    java.sql.Date fechaInicio = java.sql.Date.valueOf(idfechaa);
    java.sql.Date fechaFin = java.sql.Date.valueOf(idfechab);

    // Agregar las fechas a los parámetros
    parametros.put("idfechaa", fechaInicio);
    parametros.put("idfechab", fechaFin);
    parametros.put("estado", codigo);
    parametros.put("nombre_usu", nombre_usu);
}
        
        byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, conn);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);

        ServletOutputStream output = response.getOutputStream();
        response.getOutputStream();
        output.write(bytes, 0, bytes.length);
        output.flush();
        output.close();
    } catch (java.io.FileNotFoundException ex) {
        ex.getMessage();
    }
%>



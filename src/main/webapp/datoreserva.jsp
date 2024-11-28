<%-- 
    Document   : datoreserva
    Created on : 11 oct. 2024, 14:44:51
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
        File reportFile = new File(application.getRealPath("reportes/reportecaberareserva.jasper"));
        /**/
        Map parametros = new HashMap();

     String codigo = request.getParameter("cab");
          // String codigo = "1";
        int c = Integer.parseInt(codigo);
        parametros.put("cabreserva", c);
        
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


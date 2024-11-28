<%@ page import="net.sf.jasperreports.engine.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.text.*" %> 
<%@ page import="java.sql.Date" %>

<%@ include file="jsp/conexion.jsp" %>

<%@ page contentType="application/pdf" pageEncoding="UTF-8"%>
<%    try {
        /*INDICAMOS EL LUGAR DONDE SE ENCUENTRA NUESTRO ARCHIVO JASPER*/
        File reportFile = new File(application.getRealPath("reportes/unoautores.jasper"));
        /**/
        Map parametros = new HashMap();

     String codigo = request.getParameter("per");
          // String codigo = "1";
        int c = Integer.parseInt(codigo);
        parametros.put("idautor", c);
        
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


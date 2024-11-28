<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>

<%@ page import="net.sf.jasperreports.engine.*" %>
<%@ page import="net.sf.jasperreports.engine.util.*" %>
<%@ include file="jsp/conexion.jsp" %>

<%@ page contentType="application/pdf" pageEncoding="UTF-8"%>
<%
    try {
        // Indicar el lugar donde se encuentra el archivo Jasper
        File reportFile = new File(application.getRealPath("reportes/informereserva.jasper"));
        Map<String, Object> parametros = new HashMap<>();

        // Obtener las fechas desde la solicitud
        String idfechaa = request.getParameter("idfechaa");
        String idfechab = request.getParameter("idfechab");
        String codigo = request.getParameter("e");
        String nombre_usu = request.getParameter("nombre_usu");

        // Comprobar si las fechas no son nulas
        if (idfechaa != null && idfechab != null) {
            // Convertir las fechas de String a java.util.Date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date fechaA = sdf.parse(idfechaa);
            java.util.Date fechaB = sdf.parse(idfechab);
            
            // Agregar las fechas a los parámetros
            parametros.put("idfechaa", fechaA);
            parametros.put("idfechab", fechaB);
            parametros.put("estado", codigo);
            parametros.put("nombre_usu", nombre_usu);
        } else {
            // Manejo de error si las fechas son nulas
            out.println("Error: Las fechas son nulas.");
            return; // Terminar la ejecución
        }

        // Ejecutar el informe
        byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, conn);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);

        ServletOutputStream output = response.getOutputStream();
        output.write(bytes, 0, bytes.length);
        output.flush();
        output.close();
    } catch (java.io.FileNotFoundException ex) {
        out.println("Error: No se encontró el archivo del reporte. " + ex.getMessage());
    } catch (ParseException e) {
        out.println("Error: Formato de fecha incorrecto. Asegúrate de usar el formato 'yyyy-MM-dd'.");
    } catch (Exception e) {
        out.println("Error: Ocurrió un error inesperado. " + e.getMessage());
    }
%>

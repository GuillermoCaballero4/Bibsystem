<%@ page import="net.sf.jasperreports.engine.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="net.sf.jasperreports.engine.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="jsp/conexion.jsp" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%! 
    String convertirNumeroALetras(long numero) {
        if (numero == 0) return "Cero";

        String[] unidades = {"", "Uno", "Dos", "Tres", "Cuatro", "Cinco", "Seis", "Siete", "Ocho", "Nueve"};
        String[] especiales = {"Diez", "Once", "Doce", "Trece", "Catorce", "Quince", "Dieciséis", "Diecisiete", "Dieciocho", "Diecinueve"};
        String[] decenas = {"", "", "Veinte", "Treinta", "Cuarenta", "Cincuenta", "Sesenta", "Setenta", "Ochenta", "Noventa"};
        String[] centenas = {"", "Ciento", "Doscientos", "Trescientos", "Cuatrocientos", "Quinientos", "Seiscientos", "Setecientos", "Ochocientos", "Novecientos"};
        
        String letras = "";

        if (numero >= 1000000) {  // Millones
            letras += convertirNumeroALetras(numero / 1000000) + " Millón";
            if (numero / 1000000 > 1) letras += "es";
            numero %= 1000000;
            if (numero > 0) letras += " ";
        }

        if (numero >= 1000) {  // Miles
            letras += convertirNumeroALetras(numero / 1000) + " Mil";
            numero %= 1000;
            if (numero > 0) letras += " ";
        }

        if (numero >= 100) {  // Centenas
            if (numero == 100) {
                letras += "Cien";
            } else {
                letras += centenas[(int) (numero / 100)];
            }
            numero %= 100;
            if (numero > 0) letras += " ";
        }

        if (numero >= 20) {  // Decenas
            letras += decenas[(int) (numero / 10)];
            numero %= 10;
            if (numero > 0) letras += " y ";
        } else if (numero >= 10) {  // Números especiales entre 10 y 19
            letras += especiales[(int) (numero - 10)];
            numero = 0;
        }

        if (numero > 0) {  // Unidades
            letras += unidades[(int) numero];
        }

        return letras.trim();
    }
%>



<%
    try {
        // INDICAMOS EL LUGAR DONDE SE ENCUENTRA NUESTRO ARCHIVO JASPER
        File reportFile = new File(application.getRealPath("reportes/reporte.jasper"));
        Map<String, Object> parametros = new HashMap<>();

        // Obtener los parámetros del request
        String cobrado = request.getParameter("monto_cobrado");
        String montoEnLetras = "Cero"; // Valor por defecto
        String codigo = request.getParameter("per");

        // Validar parámetros
        if (codigo == null || codigo.isEmpty()) {
            out.println("Error: Código no es válido.");
            return;
        }

        // Convertir código a entero
        int c = Integer.parseInt(codigo);
        parametros.put("idcobro_multa", c);

        // Convertir monto_cobrado a letras
        if (cobrado != null && !cobrado.isEmpty()) {
            try {
                BigDecimal montoCobrado = new BigDecimal(cobrado);
                montoEnLetras = convertirNumeroALetras(montoCobrado.longValue());
            } catch (NumberFormatException e) {
                out.println("Error: Monto cobrado no es un número válido.");
                return;
            }
        }

        // Agregar el monto en letras a los parámetros
        parametros.put("monto_cobrado", montoEnLetras);

        // Generar el informe
        byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, conn);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream output = response.getOutputStream();
        output.write(bytes, 0, bytes.length);
        output.flush();
        output.close();
    } catch (FileNotFoundException ex) {
        out.println("Error: Archivo no encontrado - " + ex.getMessage());
    } catch (JRException e) {
        out.println("Error generando el informe: " + e.getMessage());
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>

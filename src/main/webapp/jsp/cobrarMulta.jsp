<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>

<%
String idpersona = request.getParameter("idpersona");
String iddevolucion = request.getParameter("iddevolucion");
String fecha = request.getParameter("fecha_co");
String monto_multa = request.getParameter("monto_multa");
String message = "";
String metodoPago = request.getParameter("metodoPago");
String idcobro_multa = request.getParameter("idcobro_multa");

/*int idcobro_multaInt = Integer.parseInt(idcobro_multa);

String sqlmetododepago = "INSERT INTO metodo_de_de_pago (descripcion, idcobro_multa) VALUES (?,?)";
PreparedStatement psmetododepago = conn.prepareStatement(sqlmetododepago);
psmetododepago.setString(1, metodoPago);
psmetododepago.setInt(2, idcobro_multaInt);// Utiliza setString en lugar de setInt
int rowsUpdatedmetododepago = psmetododepago.executeUpdate();
*/

boolean idValido = true;

// Verificar si se reciben los parámetros
if (idpersona == null || idpersona.isEmpty()) {
    message = "<div class='alert alert-danger' role='alert'>ID Persona recibido: null o vacío</div>";
    idValido = false;
} else {
    message = "<div class='alert alert-info' role='alert'>ID Persona recibido: " + idpersona + "</div>";
}

if (iddevolucion == null || iddevolucion.isEmpty()) {
    message += "<div class='alert alert-danger' role='alert'>ID Devolución recibido: null o vacío</div>";
    idValido = false;
} else {
    message += "<div class='alert alert-info' role='alert'>ID Devolución recibido: " + iddevolucion + "</div>";
}

response.getWriter().write(message); // Para depurar si los datos están bien recibidos

if (idValido) {
    try {
        // Comenzamos una transacción
        conn.setAutoCommit(false);

        // Convertir los IDs a enteros
        int idPersonaInt = Integer.parseInt(idpersona);
        int idDevolucionInt = Integer.parseInt(iddevolucion);
        
           
        
        // Actualizar el monto de la multa en la tabla devoluciones a 0
        String sqlDevoluciones = "UPDATE devoluciones SET monto_multa = 0 WHERE iddevolucion = ?";
        PreparedStatement psDevoluciones = conn.prepareStatement(sqlDevoluciones);
        psDevoluciones.setInt(1, idDevolucionInt);
        int rowsUpdatedDevoluciones = psDevoluciones.executeUpdate();

        // Actualizar el estado en la tabla cobro_de_multa
        String sqlCobroMulta = "UPDATE cobro_de_multa SET estado_co = 'Cobrado', fecha_co = '" + fecha + "', monto_cobrado = '"+ monto_multa +"',idmetododepago = '"+ metodoPago +"'  WHERE idpersona = ? AND iddevolucion = ?";
        PreparedStatement psCobroMulta = conn.prepareStatement(sqlCobroMulta);
        psCobroMulta.setInt(1, idPersonaInt);
        psCobroMulta.setInt(2, idDevolucionInt);
        int rowsUpdatedCobroMulta = psCobroMulta.executeUpdate();

        // Verificar si ambas consultas afectaron filas
        if (rowsUpdatedDevoluciones > 0 && rowsUpdatedCobroMulta > 0) {
            conn.commit(); // Confirmamos la transacción
            message += "<div class='alert alert-success' role='alert'>Multa cobrada exitosamente y monto actualizado a 0.</div>";
        } else {
            conn.rollback(); // Si alguna falla, hacemos rollback
            message += "<div class='alert alert-warning' role='alert'>No se encontró la multa para cobrar.</div>";
        }

        // Cerrar los PreparedStatements
        psDevoluciones.close();
        psCobroMulta.close();
    } catch (SQLException e) {
        conn.rollback(); // Si hay una excepción, hacemos rollback
        message = "<div class='alert alert-danger' role='alert'>Error al cobrar la multa: " + e.getMessage() + "</div>";
        e.printStackTrace();
    } finally {
        conn.setAutoCommit(true); // Restaurar el modo autocommit
    }
}

response.getWriter().write(message); // Retorna el mensaje final después de intentar el cobro
%>

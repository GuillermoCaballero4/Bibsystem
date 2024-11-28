<%-- 
    Document   : prestamo
    Created on : 16 sept. 2024, 17:33:09
    Author     : david
--%>
<%@ page import="java.sql.*" %>

<%@include file="conexion.jsp"%>
<%    if (request.getParameter("listar").equals("cargar")) {

        // Parámetros de la solicitud
        String idusuario = request.getParameter("idusuario");
        String idreserva = request.getParameter("idreserva");
        String fechaprestamo = request.getParameter("fechaprestamo");
        String fechadevolucion = request.getParameter("fechadevolucion");

        String cantidad = request.getParameter("cantidad");

        try {
            Statement st = null;
            ResultSet rs = null;
            ResultSet pk = null;
            st = conn.createStatement();

            // Verificar si hay prestamos pendientes
            rs = st.executeQuery("SELECT idprestamo FROM prestamos WHERE estadoprestamo='Pendiente';");
            if (rs.next()) {
                // Si existe una cabecera pendiente, agregar detalle de prestamo
                st.executeUpdate("INSERT INTO detalle_de_prestamos (idprestamo, cantidad) VALUES ('" + rs.getString(1) + "','" + cantidad + "')");
            } else {
                // Si no existe una cabecera pendiente, crear una nuevo prestamo y agregar detalle

                st.executeUpdate("INSERT INTO prestamos ( idusuario, idreserva, fechaprestamo, fechadevolucion) VALUES ('" + idusuario + "','" + idreserva + "','" + fechaprestamo + "','" + fechadevolucion + "')");
                pk = st.executeQuery("SELECT idprestamo FROM prestamos WHERE estadoprestamo='Pendiente';");
                pk.next();
                st.executeUpdate("INSERT INTO detalle_de_prestamos (idprestamo, cantidad) VALUES ('" + pk.getString(1) + "','" + cantidad + "')");

            }

        } catch (Exception e) {
            out.println("error PSQL: " + e);

        }
    } // Para listar el detalle
    else if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            ResultSet pk = null;
            st = conn.createStatement();
            //si ahi un estado pendiente que lo seleccione 
            pk = st.executeQuery("SELECT idprestamo FROM prestamos WHERE estadoprestamo='Pendiente';");
            pk.next();

            rs = st.executeQuery("SELECT dp.iddetalle_prestamo, l.titulo_libro, dtr.cantidad_reserva "
                    + "FROM detalle_de_prestamos dp "
                    + "INNER JOIN prestamos pr ON pr.idprestamo = dp.idprestamo "
                    + "INNER JOIN reservas r ON r.idreserva = pr.idreserva "
                    + "INNER JOIN detalle_reserva_de_libros dtr ON dtr.idreserva = r.idreserva "
                    + "INNER JOIN libros l ON dtr.idlibro = l.idlibro "
                    + "WHERE dp.idprestamo = '" + pk.getString(1) + "'");

            // sin el while no funciona no toque     
            while (rs.next()) {


%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(3)); %></td>

    <td><i class="bi bi-trash" data-toggle="modal" data-target="#basicModal" onclick="$('#pkdel').val(<%out.print(rs.getString(1));%>)"></i></td>
</tr>
<%   }
    } catch (Exception e) {
        System.out.println("Error de PSQL: " + e);

    }

} else if (request.getParameter("listar").equals("eliminarprestamo")) {

    String pk = request.getParameter("pkd");
    try {
        Statement st = null;
        st = conn.createStatement();
        st.executeUpdate("DELETE FROM detalle_de_prestamos WHERE iddetalle_prestamo=" + pk);
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }

} else if (request.getParameter("listar").equals("cancelarprestamo")) {

    try {
        Statement st = null;
        ResultSet pk = null;
        st = conn.createStatement();
        // Seleccionamos el préstamo con estado 'Pendiente'
        pk = st.executeQuery("SELECT idprestamo, idreserva FROM prestamos WHERE estadoprestamo='Pendiente';");
        if (pk.next()) {
            String idPrestamo = pk.getString("idprestamo");
            String idReserva = pk.getString("idreserva");
            // Obtenemos el idlibro del formulario
            String idLibro = request.getParameter("idlibro");
            String cantidad = request.getParameter("cantidad");
            // Actualizamos el estado del préstamo a 'Finalizado'
            st.executeUpdate("UPDATE prestamos SET estadoprestamo='Cancelado' WHERE idprestamo=" + idPrestamo);
            // Actualizamos el estado de la reserva a 'Prestado'
            st.executeUpdate("UPDATE reservas SET estado='Finalizado' WHERE idreserva=" + idReserva);
            // Restamos la cantidad correspondiente en la tabla ajustes

            out.println("Préstamo Cancelado ");
        } else {
            out.println("No hay préstamos pendientes para registrar.");
        }
    } catch (Exception e) {
        out.println("Error PSQL: " + e.getMessage());
    }
// cuando se registra el prestamo se tiene que actualizar el estado de la reserva a prestado
} else if (request.getParameter("listar").equals("registrarprestamo")) {
    try {
        Statement st = null;
        ResultSet pk = null;
        st = conn.createStatement();
        // Seleccionamos el préstamo con estado 'Pendiente'
        pk = st.executeQuery("SELECT p.idprestamo, p.idreserva, d.idlibro, d.cantidad_reserva  FROM prestamos p inner join detalle_reserva_de_libros d on d.idreserva = p.idreserva WHERE estadoprestamo='Pendiente' ;" );
        if (pk.next()) {
            String idPrestamo = pk.getString("idprestamo");
            String idReserva = pk.getString("idreserva");
            String cantidad_reserva = pk.getString("cantidad_reserva");
            // Obtenemos el idlibro del formulario
            String idlibro = pk.getString("idlibro");
            // Actualizamos el estado del préstamo a 'Finalizado'
            st.executeUpdate("UPDATE prestamos SET estadoprestamo='Finalizado' WHERE idprestamo=" + idPrestamo);
            // Actualizamos el estado de la reserva a 'Prestado'
            st.executeUpdate("UPDATE reservas SET estado='Prestado' WHERE idreserva=" + idReserva);
            
            String sql = "UPDATE ajustes SET cantidad_ajuste = cantidad_ajuste - ? WHERE idlibro = ?";
PreparedStatement pst = conn.prepareStatement(sql);
 pst.setInt(1, Integer.parseInt(cantidad_reserva)); // Convertir a entero si aplica
            pst.setInt(2, Integer.parseInt(idlibro));        // Para el WHERE
   // Reemplaza con el identificador de la fila a actualizar
int rowsAffected = pst.executeUpdate();
System.out.println("Filas actualizadas: " + rowsAffected);

            out.println("Préstamo finalizado ");
        } else {
            out.println("No hay préstamos pendientes para registrar.");
        }
    } catch (Exception e) {
        out.println("Error PSQL: " + e.getMessage());
    }
} else if (request.getParameter("listar").equals("listarre")) {
    try {
        Statement st = null;
        ResultSet rs = null;

        st = conn.createStatement();
        //si ahi un estado pendiente que lo seleccione 

        rs = st.executeQuery("SELECT p.idprestamo, TO_CHAR(p.fechaprestamo, 'dd-mm-YYYY') AS fecha_prestamo, u.nombre_usu, per.nombre_persona, TO_CHAR(p.fechadevolucion, 'dd-mm-YYYY') AS fecha_devolucion, p.estadoprestamo, dtr.idlibro, dtr.cantidad_reserva "
                + "FROM prestamos p "
                + "INNER JOIN usuarios u ON u.idusuario = p.idusuario "
                + "INNER JOIN reservas r ON r.idreserva = p.idreserva "
                + "INNER JOIN personas per ON per.idpersona = r.idpersona "
                + "left JOIN devoluciones dev ON dev.idprestamo = p.idprestamo "
                + "left JOIN detalle_reserva_de_libros dtr ON dtr.idreserva = p.idreserva "
                + "WHERE p.estadoprestamo = 'Finalizado' ");
               

        // sin el while no funciona no toque     
        while (rs.next()) {


%>
<tr>

    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(6)); %></td>
    <td><i class="bi bi-trash" data-toggle="modal" data-target="#basicModal" onclick="
    $('#pkanul').val('<%= rs.getString(1) %>'); 
    $('#cantidad_reserva').val('<%= rs.getString("cantidad_reserva") %>'); 
    $('#idlibro').val('<%= rs.getString(7) %>');">
</i>
        <a target="blank_" href="datoprestamo.jsp?cab=<%= rs.getString("idprestamo")%>" >
            <i class="bi bi-eye icono-negro"></i>
        </a> </td>
</tr>
<%

            }
        } catch (Exception e) {
            out.println("error PSQL: " + e);
        }
//aqui al anular el prestamo tengo que anular tambien la reserva
    } else if (request.getParameter("listar").equals("anularreserva")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        
        // Obtener parámetros de la solicitud
        String idpkreserva = request.getParameter("idpkreserva");
        String cantidad_reserva = request.getParameter("cantidad_reserva");
        String idlibro = request.getParameter("idlibro");

        // Validar que los parámetros no sean nulos
        if (idpkreserva == null || cantidad_reserva == null || idlibro == null) {
            out.println("Error: Parámetros faltantes.");
            return;
        }

        // Consulta segura para obtener idreserva
        String query = "SELECT idreserva FROM prestamos WHERE idprestamo = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(idpkreserva)); // Convertir idpkreserva a entero

        rs = ps.executeQuery();
        if (rs.next()) {
            String idReserva = rs.getString("idreserva");

            // 1. Actualizar el estado del préstamo
            String updatePrestamo = "UPDATE prestamos SET estadoprestamo = 'Anulado' WHERE idprestamo = ?";
            PreparedStatement pstPrestamo = conn.prepareStatement(updatePrestamo);
            pstPrestamo.setInt(1, Integer.parseInt(idpkreserva));
            pstPrestamo.executeUpdate();

            // 2. Actualizar el estado de la reserva
            String updateReserva = "UPDATE reservas SET estado = 'Finalizado' WHERE idreserva = ?";
            PreparedStatement pstReserva = conn.prepareStatement(updateReserva);
            pstReserva.setInt(1,Integer.parseInt(idReserva));
            pstReserva.executeUpdate();

            // 3. Actualizar cantidad en ajustes
            String sql = "UPDATE ajustes SET cantidad_ajuste = cantidad_ajuste + ? WHERE idlibro = ?";
PreparedStatement pst = conn.prepareStatement(sql);
 pst.setInt(1, Integer.parseInt(cantidad_reserva)); // Convertir a entero si aplica
            pst.setInt(2, Integer.parseInt(idlibro));        // Para el WHERE
   // Reemplaza con el identificador de la fila a actualizar
int rowsAffected = pst.executeUpdate();
System.out.println("Filas actualizadas: " + rowsAffected);

            out.println("Prestamo anulado correctamente.");
        } else {
            out.println("No se encontró el préstamo con el ID: " + idpkreserva);
        }
    } catch (Exception e) {
        out.println("Error PSQL: " + e.getMessage());
    } 
}



%>

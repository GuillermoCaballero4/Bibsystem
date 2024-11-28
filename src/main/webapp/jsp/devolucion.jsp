<%-- 
    Document   : devolucion
    Created on : 24 sept. 2024, 19:56:29
    Author     : david
--%>


<%@include file="conexion.jsp"%>
<% 
if (request.getParameter("listar").equals("cargar")) {

    // Parámetros de la solicitud
    //cabecera
    String idusuario = request.getParameter("idusuario");
    String idprestamo = request.getParameter("idprestamo");
    String monto_multa = request.getParameter("monto_multa");
    String motivo_multa = request.getParameter("motivo_multa");
    String fecha_de_la_dev = request.getParameter("fecha_de_la_dev");
    //detalle
    String cantidad_dev = request.getParameter("cantidad_dev");
    
    out.print("monto_multa");
    out.print("monto_multa");
    try {
        Statement st = null;
        ResultSet rs = null;
        ResultSet pk = null;
        st = conn.createStatement();

        // Verificar si hay reservas pendientes
        rs = st.executeQuery("SELECT iddevolucion FROM devoluciones WHERE estado='Pendiente';");
        if (rs.next()) {
            // Si existe una cabecera pendiente, agregar detalle de reserva
            st.executeUpdate("INSERT INTO detalle_devolucion (iddevolucion, cantidad_dev) VALUES ('" + rs.getString(1) + "','" + cantidad_dev + "')");
        } else {
            // Si no existe una cabecera pendiente, crear una nueva reserva y agregar detalle
            st.executeUpdate("INSERT INTO devoluciones (idprestamo, idusuario, monto_multa,motivo_multa,fecha_de_la_dev) VALUES ('" + idprestamo + "','" + idusuario + "','" + monto_multa + "','" + motivo_multa + "','" + fecha_de_la_dev + "')");
            pk = st.executeQuery("SELECT iddevolucion FROM devoluciones WHERE estado='Pendiente';");
            pk.next();
            st.executeUpdate("INSERT INTO detalle_devolucion (iddevolucion, cantidad_dev) VALUES ('" + pk.getString(1) + "','" + cantidad_dev + "')");
        }

    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
} 
// Para listar el detalle
 else if (request.getParameter("listar").equals("listar")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        ResultSet pk = null;
        st = conn.createStatement();
       //si ahi un estado pendiente que lo seleccione 
        pk = st.executeQuery("SELECT iddevolucion FROM devoluciones WHERE estado='Pendiente';");
        pk.next();
        
        rs = st.executeQuery("SELECT dd.id_detalle_devolucion, l.titulo_libro, dd.cantidad_dev " +
                     "FROM detalle_devolucion dd " +
                     "INNER JOIN devoluciones d on d.iddevolucion = dd.iddevolucion " +
                     "INNER JOIN detalle_de_prestamos dp on d.idprestamo = dp.idprestamo " + 
                     "INNER JOIN prestamos pr ON pr.idprestamo = dp.idprestamo " +
                     "INNER JOIN reservas r ON r.idreserva = pr.idreserva " +
                     "INNER JOIN detalle_reserva_de_libros dtr ON dtr.idreserva = r.idreserva " +
                     "INNER JOIN libros l ON dtr.idlibro = l.idlibro " +
                     "WHERE dd.iddevolucion = '" + pk.getString(1) + "'");
   // sin el while no funciona no toque     
        while (rs.next()) {
            
            
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
    
    <td><i class="bi bi-trash" data-toggle="modal" data-target="#basicModal" onclick="$('#pkdel').val(<%out.print(rs.getString(1));%>)"></i>
    <!-- Icono en la tabla para abrir el modal de multa -->
<i class="bi bi-pencil" data-toggle="modal" data-target="#modalMulta"></i>

    
    </td>
    
</tr>
<%   }
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
} else if (request.getParameter("listar").equals("elimredev")) {

    String pk = request.getParameter("pkd");
    try {
        Statement st = null;
        st = conn.createStatement();
        st.executeUpdate("DELETE FROM detalle_devolucion WHERE id_detalle_devolucion=" + pk);
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
} else if (request.getParameter("listar").equals("cancelardev")) {

    try {
        Statement st = null;
        ResultSet pk = null;
        st = conn.createStatement();
        pk = st.executeQuery("SELECT iddevolucion FROM devoluciones WHERE estado='Pendiente';");
        pk.next();
        st.executeUpdate("UPDATE devoluciones SET estado='Cancelado' WHERE iddevolucion=" + pk.getString(1));
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
} 

else if (request.getParameter("listar").equals("finaldev")) {
    try {
        Statement st = null;
        ResultSet pk = null, rs = null;
        st = conn.createStatement();
        

        // Consulta para obtener iddevolucion y los datos de la reserva a través de prestamos
        pk = st.executeQuery("SELECT d.iddevolucion, p.idreserva, r.idpersona, r.idusuario, d.idprestamo, dtr.idlibro, dtr.cantidad_reserva " +
                             "FROM devoluciones d " +
                             "JOIN prestamos p ON d.idprestamo = p.idprestamo " +
                             "JOIN reservas r ON p.idreserva = r.idreserva " +
                             "join detalle_reserva_de_libros dtr on dtr.idreserva = p.idreserva " +
                             "WHERE d.estado = 'Pendiente';");
         String monto_multa = request.getParameter("monto_multa");
    String motivo_multa = request.getParameter("motivo_multa");


        if (pk.next()) {
            String idDevolucion = pk.getString("iddevolucion");
            String idReserva = pk.getString("idreserva");
            String idPersona = pk.getString("idpersona"); 
            String idUsuario = pk.getString("idusuario"); 
            String idPrestamo = pk.getString("idprestamo"); 
            // Obtenemos el idlibro del formulario para el ajuste
            String cantidad_reserva = pk.getString("cantidad_reserva");
String idlibro = pk.getString("idlibro");
            st.executeUpdate("UPDATE devoluciones SET monto_multa = '"+ monto_multa +"', motivo_multa ='"+ motivo_multa +"' WHERE iddevolucion=" + idDevolucion);
            // Actualizamos el estado de la devolución a 'Finalizado'
            st.executeUpdate("UPDATE devoluciones SET estado='Finalizado' WHERE iddevolucion=" + idDevolucion);

            st.executeUpdate("UPDATE prestamos SET estadoprestamo='Devuelto' WHERE idprestamo=" + idPrestamo);
            // Actualizamos el estado de la reserva a 'Devuelto'
            st.executeUpdate("UPDATE reservas SET estado='Devuelto' WHERE idreserva=" + idReserva);
            
            
            // Insertar el cobro de multa 
            // Fecha actual para el cobro
            String estadoCobro = "'Pendiente'"; 
            
            // Inserta el cobro de multa en la tabla
            String insertCobroMulta = "INSERT INTO cobro_de_multa (iddevolucion, estado_co, idusuario, idpersona) " +
                                     "VALUES (" + idDevolucion + ", " + estadoCobro + ", " + idUsuario + ", " + idPersona + ")";
            
            st.executeUpdate(insertCobroMulta);
            
             String sql = "UPDATE ajustes SET cantidad_ajuste = cantidad_ajuste + ? WHERE idlibro = ?";
PreparedStatement pst = conn.prepareStatement(sql);
 pst.setInt(1, Integer.parseInt(cantidad_reserva)); // Convertir a entero si aplica
            pst.setInt(2, Integer.parseInt(idlibro));        // Para el WHERE
   // Reemplaza con el identificador de la fila a actualizar
int rowsAffected = pst.executeUpdate();
System.out.println("Filas actualizadas: " + rowsAffected);
            // Aumentamos la cantidad en el ajuste
          
            
            out.println("Devolución finalizada, estado de la reserva actualizado a 'Devuelto', cobro de multa registrado y cantidad del libro actualizada.");
        
        } else {
            out.println("No hay devoluciones pendientes para registrar.");
        }
    
    } catch (Exception e) {
        out.println("Error PSQL: " + e.getMessage());
    }
}
/*else if (request.getParameter("listar").equals("finaldevprestamo")) {
    try {
        Statement st = conn.createStatement();
        
        // Consulta para obtener iddevolucion y los datos de la reserva a través de prestamos
        ResultSet pk = st.executeQuery("SELECT d.iddevolucion, d.idprestamo " +
                                        "FROM devoluciones d " +
                                        "JOIN prestamos p ON d.idprestamo = p.idprestamo");
        
        if (pk.next()) {
            String idprestamo = pk.getString("idprestamo"); 
            
            // Actualizamos el estado de la reserva a 'Devuelto'
            int rowsUpdated = st.executeUpdate("UPDATE prestamos SET estadoprestamo='Devuelto' WHERE idprestamo=" + idprestamo);
            
            if (rowsUpdated > 0) {
                // Aquí puedes agregar la lógica para insertar el cobro de multa y otros ajustes
                out.println("Devolución finalizada, estado de la reserva actualizado a 'Devuelto'.");
            } else {
                out.println("No se pudo actualizar el estado de la reserva.");
            }
        } else {
            out.println("No hay devoluciones pendientes para registrar.");
        }
    
    } catch (SQLException e) {
        out.println("Error PSQL: " + e.getMessage());
        e.printStackTrace(); // Esto te dará más información sobre el error
    }
}*/
else if (request.getParameter("listar").equals("listarre")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        
        st = conn.createStatement();
       //si ahi un estado pendiente que lo seleccione 
        
        
        rs = st.executeQuery("SELECT d.iddevolucion, TO_CHAR(d.fecha_de_la_dev,'dd-mm-YYYY'), p.nombre_persona, d.estado, d.idprestamo, dtr.idlibro, dtr.cantidad_reserva FROM devoluciones d, personas p, reservas r, prestamos pr, detalle_reserva_de_libros dtr WHERE r.idpersona = p.idpersona AND pr.idreserva = r.idreserva AND d.idprestamo = pr.idprestamo AND  dtr.idreserva = pr.idreserva AND d.estado='Finalizado'");
   // sin el while no funciona no toque     
        while (rs.next()) {
            
            
%>
<tr>

    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td><i class="bi bi-trash" data-toggle="modal" data-target="#basicModal" onclick="
    $('#pkanul').val(<%= rs.getString(1) %>); 
    $('#pkprestamo').val('<%= rs.getString(5) %>'); 
    $('#cantidad_reserva').val('<%= rs.getString("cantidad_reserva") %>'); 
    $('#idlibro').val('<%= rs.getString("idlibro") %>');">
</i>

    <a target="blank_" href="datodevolucion.jsp?cab=<%= rs.getString("iddevolucion") %>" >
            <i class="bi bi-eye icono-negro"></i>
        </a> </td>
</tr>
<%

        }
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
} 

else if (request.getParameter("listar").equals("anuldev")) {
    try {
        Statement st = null;
        st = conn.createStatement();
        
        // Obtenemos el iddevolucion
        String idDevolucion = request.getParameter("idpkreserva");
        
        String ID = request.getParameter("idprestamo");
        
         String cantidad_reserva = request.getParameter("cantidad_reserva");
        String idlibro = request.getParameter("idlibro");

         st.executeUpdate("UPDATE prestamos SET estadoprestamo='Finalizado' WHERE idprestamo=" + ID);
        // Actualizar estado devolución
 //st.executeUpdate("UPDATE devoluciones SET estado='Anulado' WHERE iddevolucion=" + idDevolucion);
        st.executeUpdate("UPDATE devoluciones SET estado='Anulado' WHERE iddevolucion=" + idDevolucion);
        
        // Obtenemos el idlibro del formulario
         String sql = "UPDATE ajustes SET cantidad_ajuste = cantidad_ajuste - ? WHERE idlibro = ?";
PreparedStatement pst = conn.prepareStatement(sql);
 pst.setInt(1, Integer.parseInt(cantidad_reserva)); // Convertir a entero si aplica
            pst.setInt(2, Integer.parseInt(idlibro));        // Para el WHERE
   // Reemplaza con el identificador de la fila a actualizar
int rowsAffected = pst.executeUpdate();
System.out.println("Filas actualizadas: " + rowsAffected);
        
        // Restar cantidad en ajustes
      
        
        // Eliminar cobro de multa
        st.executeUpdate("DELETE FROM cobro_de_multa WHERE iddevolucion=" + idDevolucion);
        
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
}

%>

<%-- 
    Document   : donaciones
    Created on : 11 ago. 2024, 15:38:18
    Author     : david
--%>
<%@include file="conexion.jsp"%>
<% 
if (request.getParameter("listar").equals("cargar")) {

    // Parámetros de la solicitud
    String idpersona = request.getParameter("idpersona");
    String fecha_donacion = request.getParameter("fecha_donacion");
    String idlibro = request.getParameter("idlibro");
    String cantidadonacion = request.getParameter("cantidadonacion");

    try {
        Statement st = null;
        ResultSet rs = null;
        ResultSet pk = null;
        st = conn.createStatement();

        // Verificar si hay donaciones pendientes
        rs = st.executeQuery("SELECT iddonacion FROM donaciones WHERE estado='Pendiente';");
        if (rs.next()) {
            // Si existe una cabecera pendiente, agregar detalle de donación
            st.executeUpdate("INSERT INTO detalle_donaciones_libros (iddonacion, idlibro, cantidadonacion) VALUES ('" + rs.getString(1) + "','" + idlibro + "','" + cantidadonacion + "')");
        } else {
            // Si no existe una cabecera pendiente, crear una nueva donación y agregar detalle
            st.executeUpdate("INSERT INTO donaciones (idpersona, fecha_donacion) VALUES ('" + idpersona + "','" + fecha_donacion + "')");
            pk = st.executeQuery("SELECT iddonacion FROM donaciones WHERE estado='Pendiente';");
            pk.next();
            st.executeUpdate("INSERT INTO detalle_donaciones_libros (iddonacion, idlibro, cantidadonacion) VALUES ('" + pk.getString(1) + "','" + idlibro + "','" + cantidadonacion + "')");
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
        //si hay un estado pendiente que lo seleccione 
        pk = st.executeQuery("SELECT iddonacion FROM donaciones WHERE estado='Pendiente';");
        pk.next();
        
        rs = st.executeQuery("SELECT dtd.iddetalle_donacion_libro, l.titulo_libro, dtd.cantidadonacion FROM detalle_donaciones_libros dtd, libros l WHERE dtd.idlibro=l.idlibro AND dtd.iddonacion='" + pk.getString(1) + "'");
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
        out.println("error PSQL: " + e);
    }
} else if (request.getParameter("listar").equals("elimregdonacion")) {

    String pk = request.getParameter("pkd");
    try {
        Statement st = null;
        st = conn.createStatement();
        st.executeUpdate("DELETE FROM detalle_donaciones_libros WHERE iddetalle_donacion_libro=" + pk);
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
} else if (request.getParameter("listar").equals("canceldonacion")) {

    try {
        Statement st = null;
        ResultSet pk = null;
        st = conn.createStatement();
        pk = st.executeQuery("SELECT iddonacion FROM donaciones WHERE estado='Pendiente';");
        pk.next();
        st.executeUpdate("UPDATE donaciones SET estado='Cancelado' WHERE iddonacion=" + pk.getString(1));
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
} else if (request.getParameter("listar").equals("finaldonacion")) {

    try {
        Statement st = null;
        ResultSet pk = null;
        st = conn.createStatement();
        pk = st.executeQuery("SELECT iddonacion FROM donaciones WHERE estado='Pendiente'");
        
        if (pk.next()) {
            int iddonacion = pk.getInt(1);
            st.executeUpdate("UPDATE donaciones SET estado='Finalizado' WHERE iddonacion=" + iddonacion);
        } else {
            out.println("No hay donaciones pendientes");
        }
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    } 
} else if (request.getParameter("listar").equals("listardonaciones")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        
        st = conn.createStatement();
        //si hay un estado pendiente que lo seleccione 
        rs = st.executeQuery("SELECT d.iddonacion, TO_CHAR(d.fecha_donacion,'dd-mm-YYYY'), p.nombre_persona, d.estado FROM donaciones d, personas p WHERE d.idpersona = p.idpersona AND d.estado='Finalizado'");
        // sin el while no funciona no toque     
        while (rs.next()) {
            
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td><i class="bi bi-trash" data-toggle="modal" data-target="#basicModal" onclick="$('#pkanul').val(<% out.print(rs.getString(1)); %>)"></i>
    <a target="blank_" href="datodonacion.jsp?cab=<%= rs.getString("iddonacion") %>" >
            <i class="bi bi-eye icono-negro"></i>
        </a> </td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
} else if (request.getParameter("listar").equals("anulardonacion")) {
    String idlibro = request.getParameter("idlibro");
    try {
        Statement st = null;
        ResultSet pk = null;
        st = conn.createStatement();
        st.executeUpdate("UPDATE donaciones SET estado='Anulado' WHERE iddonacion=" + request.getParameter("idpkdonacion"));
        st.executeUpdate("DELETE FROM libros WHERE idlibro=" + idlibro);
        st.executeUpdate("DELETE FROM ajustes WHERE idlibro=" + idlibro);
    } catch (Exception e) {
        out.println("error PSQL: " + e);
    }
}
%>





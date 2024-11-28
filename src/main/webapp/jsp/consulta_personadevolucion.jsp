<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>

<%
    try {
        Statement st = conn.createStatement();
      ResultSet rs = st.executeQuery(
    "SELECT DISTINCT on (r.idreserva) r.idreserva, pr.idprestamo, per.nombre_persona, per.ci_persona, l.titulo_libro, l.idlibro,per.idpersona , dtr.cantidad_reserva, dtr.fechafinreserva " +
    "FROM reservas r " +
    "JOIN prestamos pr on r.idreserva = pr.idreserva " +
    "JOIN personas per ON r.idpersona = per.idpersona " +
    "JOIN detalle_reserva_de_libros dtr ON r.idreserva = dtr.idreserva " +
    "JOIN libros l ON dtr.idlibro = l.idlibro " +
    "WHERE  pr.estadoprestamo = 'Finalizado'"
    );

        // Comienza a generar las opciones del select
%>

<select name="idreserva" id="idreserva" class="form-control">
    <option value="">Seleccione a la persona</option>
    <% 
        while (rs.next()) {
            int idprestamo = rs.getInt("idprestamo");
            int idreserva = rs.getInt("idreserva");
            String titulo_libro = rs.getString("titulo_libro");
            String nombre_persona = rs.getString("nombre_persona");
            String ci_persona = rs.getString("ci_persona");
            String fechadevolucion = rs.getString("fechafinreserva");
            String cantidad = rs.getString("cantidad_reserva");
    %>
    <option value="<%= idreserva %>" data-ci="<%= ci_persona %>" data-idprestamo="<%= idprestamo %>" data-titulo_libro="<%= titulo_libro %>" data-fechadevolucion="<%= fechadevolucion %>" data-cantidad="<%= cantidad %>">
        <%= nombre_persona %> - <%= ci_persona %> - <%= fechadevolucion %> 
    </option>
    <% 
        }
    %>
</select>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } 
%>

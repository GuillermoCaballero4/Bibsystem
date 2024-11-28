<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>

<%
    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT d.iddisponibilidad, " +
               "d.idlibro, " +
               "COALESCE(SUM(a.cantidad_ajuste), 0) - COALESCE(SUM(CASE WHEN rc.estado = 'Finalizado'  or rc.estado = 'Prestado' THEN r.cantidad_reserva ELSE 0 END), 0) AS cantidad_disponible, " +
               "l.titulo_libro " +
               "FROM disponibilidades d " +
               "INNER JOIN libros l ON d.idlibro = l.idlibro " +
               "LEFT JOIN ajustes a ON d.idlibro = a.idlibro " +
               "LEFT JOIN detalle_reserva_de_libros r ON d.idlibro = r.idlibro " +
               "LEFT JOIN reservas rc ON rc.idreserva = r.idreserva " +
               "GROUP BY d.iddisponibilidad, d.idlibro, l.titulo_libro " +
               "HAVING COUNT(CASE WHEN rc.estado = 'Finalizado' THEN 1 END) = 0 OR COALESCE(SUM(a.cantidad_ajuste), 0) - COALESCE(SUM(CASE WHEN rc.estado = 'Finalizado' or rc.estado = 'Prestado' THEN r.cantidad_reserva ELSE 0 END), 0) > -1");
%>

<select name="idlibro" id="idlibro" class="select2 form-control" onchange="validarDisponibilidad(this.value)">
    <option value="">Seleccione un libro existente</option>
    
    <% 
        while (rs.next()) {
            int idlibro = rs.getInt("idlibro");
            int cantidadDisponible = rs.getInt("cantidad_disponible");
            String titulo_libro = rs.getString("titulo_libro");
    %>
    <option value="<%= idlibro %>" data-cantidad-disponible="<%= cantidadDisponible %>" data-select2-id="<%= idlibro %>"><%= titulo_libro %></option>
    <% 
        }
    %>
</select>   





<%
    } catch (SQLException e) {
        out.println("Error SQL: " + e.getMessage());
    } catch (Exception e) { %>
<% out.println("Error general: " + e.getMessage()); %>
<% } %>

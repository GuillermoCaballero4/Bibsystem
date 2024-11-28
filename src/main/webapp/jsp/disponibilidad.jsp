<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
if ("listar".equals(request.getParameter("listar"))) {
    try {
        Statement st = conn.createStatement();
        // Consulta para calcular la cantidad disponible
        String query = "SELECT d.iddisponibilidad, " +
               "d.idlibro, " +
               "COALESCE(SUM(a.cantidad_ajuste), 0) - COALESCE(SUM(CASE WHEN rc.estado = 'Finalizado' THEN r.cantidad_reserva ELSE 0 END), 0) AS cantidad_disponible, " +
               "l.titulo_libro " +
               "FROM disponibilidades d " +
               "INNER JOIN libros l ON d.idlibro = l.idlibro " +
               "LEFT JOIN ajustes a ON d.idlibro = a.idlibro " +
               "LEFT JOIN detalle_reserva_de_libros r ON d.idlibro = r.idlibro " +
               "LEFT JOIN reservas rc ON rc.idreserva = r.idreserva " +
               "GROUP BY d.iddisponibilidad, d.idlibro, l.titulo_libro " +
               "HAVING COUNT(CASE WHEN rc.estado = 'Finalizado' THEN 1 END) = 0 OR COALESCE(SUM(a.cantidad_ajuste), 0) - COALESCE(SUM(CASE WHEN rc.estado = 'Finalizado' THEN r.cantidad_reserva ELSE 0 END), 0) > 0";




        ResultSet rs = st.executeQuery(query);
        while (rs.next()) {
%>
<tr>
    <td><%= rs.getString("iddisponibilidad") %></td>
    
    <td><%= rs.getString("titulo_libro") %></td>
    <td><%= rs.getString("cantidad_disponible") %></td>
     <!-- <td>
        Opciones aquí si es necesario 
    </td> -->
</tr>
<%
        }
    } catch (Exception e) {
        out.println("Error PSQL: " + e);
    }
} %>
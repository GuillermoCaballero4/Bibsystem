<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>

<%
    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(
            "SELECT DISTINCT ON (r.idreserva) r.idreserva, per.nombre_persona, per.ci_persona, l.titulo_libro, l.idlibro, per.idpersona, dtr.cantidad_reserva, dtr.fechafinreserva " +
            "FROM reservas r " +
            "JOIN personas per ON r.idpersona = per.idpersona " +
            "JOIN detalle_reserva_de_libros dtr ON r.idreserva = dtr.idreserva " +
            "JOIN libros l ON dtr.idlibro = l.idlibro " +
            "WHERE r.estado = 'Finalizado'"
        );
%>
        <select name="idreserva" id="idreserva" class="form-control">
            <option value="">Seleccione a la persona</option>
            <% 
                while (rs.next()) {
                    int idreserva = rs.getInt("idreserva");
                    String titulo_libro = rs.getString("titulo_libro");
                    String nombre_persona = rs.getString("nombre_persona");
                    String ci_persona = rs.getString("ci_persona");
                    String fechafinreserva = rs.getString("fechafinreserva");
                    String cantidad_reserva = rs.getString("cantidad_reserva");
                    String idlibro = rs.getString("idlibro");
                    String idpersona = rs.getString("idpersona");
            %>
            <option value="<%= idreserva %>" 
                    data-ci="<%= ci_persona %>" 
                    data-idpersona="<%= idpersona %>" 
                    data-idlibro="<%= idlibro %>" 
                    data-titulo_libro="<%= titulo_libro %>" 
                    data-fechafinreserva="<%= fechafinreserva %>" 
                    data-cantidad_reserva="<%= cantidad_reserva %>">
                <%= nombre_persona %> - <%= ci_persona %> - <%= fechafinreserva %> 
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

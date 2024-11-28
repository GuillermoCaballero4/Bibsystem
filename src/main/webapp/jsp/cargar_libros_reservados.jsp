<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>

<%
    String idreserva = request.getParameter("idreserva");
    StringBuilder tablaHtml = new StringBuilder(); // Para construir la tabla HTML

    if (idreserva != null && !idreserva.isEmpty()) {
        try {
            // Convertir idreserva a Integer si es necesario
            int idReservaInt = Integer.parseInt(idreserva); // Cambio importante: convertir a entero

            // Modificación de la consulta: seleccionar libros por idreserva
            String query = "SELECT l.titulo_libro, r.cantidad_reserva " +
                           "FROM libros l " +
                           "JOIN detalle_reserva_de_libros r ON l.idlibro = r.idlibro " +
                           "JOIN reservas re ON re.idreserva = r.idreserva " +
                           "WHERE r.idreserva = ? " ; // Filtrar por idreserva
                         
                           

            PreparedStatement pst = conn.prepareStatement(query);
            pst.setInt(1, idReservaInt); // Uso de setInt para idreserva
            ResultSet rs = pst.executeQuery();

          

            boolean tieneResultados = false;
            while (rs.next()) {
                String titulo = rs.getString("titulo_libro"); // Título del libro
                int cantidad = rs.getInt("cantidad_reserva"); // Cantidad de la reserva
                tablaHtml.append("<tr><td>").append(titulo).append("</td><td>").append(cantidad).append("</td></tr>");
                tieneResultados = true;
            }

            if (!tieneResultados) {
                tablaHtml.append("<tr><td colspan='2'>No hay libros reservados o todos están finalizados.</td></tr>");
            }

            out.print(tablaHtml.toString()); // Devolver la tabla HTML generada

        } catch (NumberFormatException e) {
            e.printStackTrace();
            out.print("<tr><td colspan='2'>Error: ID de reserva inválido.</td></tr>");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("<tr><td colspan='2'>Error al cargar los datos: " + e.getMessage() + "</td></tr>");
        }
    } else {
        out.print("<tr><td colspan='2'>Esperando Datos.</td></tr>");
    }
%>

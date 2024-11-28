
<%@ include file="conexion.jsp" %>
<%
    // Obtener el parámetro 'idanular' desde la solicitud
    String idanular = request.getParameter("idanular");

    if (idanular != null) {
        try {
            // Parsear 'idanular' a un entero
            int idCobro = Integer.parseInt(idanular);

            // Usar PreparedStatement para evitar inyección SQL
            String sql = "UPDATE cobro_de_multa SET estado_co='Anulado' WHERE idcobro_multa = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, idCobro);  // Asignamos el valor de 'idCobro' como entero

                int filasAfectadas = ps.executeUpdate();

                if (filasAfectadas > 0) {
                    // Si la actualización fue exitosa
                    out.print("Cobro anulado exitosamente.");
                } else {
                    // Si no se actualizó ninguna fila
                    out.print("No se encontró el cobro con el id proporcionado.");
                }
            }
        } catch (NumberFormatException e) {
            // Manejo de la excepción si el parámetro no es un número válido
            out.print("El parámetro 'idanular' no es un número válido.");
        } catch (SQLException e) {
            // Manejo de la excepción de base de datos
            e.printStackTrace();
            out.print("Error al actualizar el estado del cobro.");
        }
    } else {
        out.print("El parámetro 'idanular' no fue proporcionado.");
    }
%>


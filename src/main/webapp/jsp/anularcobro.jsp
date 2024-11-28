
<%@ include file="conexion.jsp" %>
<%
    // Obtener el par�metro 'idanular' desde la solicitud
    String idanular = request.getParameter("idanular");

    if (idanular != null) {
        try {
            // Parsear 'idanular' a un entero
            int idCobro = Integer.parseInt(idanular);

            // Usar PreparedStatement para evitar inyecci�n SQL
            String sql = "UPDATE cobro_de_multa SET estado_co='Anulado' WHERE idcobro_multa = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, idCobro);  // Asignamos el valor de 'idCobro' como entero

                int filasAfectadas = ps.executeUpdate();

                if (filasAfectadas > 0) {
                    // Si la actualizaci�n fue exitosa
                    out.print("Cobro anulado exitosamente.");
                } else {
                    // Si no se actualiz� ninguna fila
                    out.print("No se encontr� el cobro con el id proporcionado.");
                }
            }
        } catch (NumberFormatException e) {
            // Manejo de la excepci�n si el par�metro no es un n�mero v�lido
            out.print("El par�metro 'idanular' no es un n�mero v�lido.");
        } catch (SQLException e) {
            // Manejo de la excepci�n de base de datos
            e.printStackTrace();
            out.print("Error al actualizar el estado del cobro.");
        }
    } else {
        out.print("El par�metro 'idanular' no fue proporcionado.");
    }
%>


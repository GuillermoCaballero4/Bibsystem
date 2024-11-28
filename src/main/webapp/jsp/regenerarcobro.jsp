<%@ include file="conexion.jsp" %>
<%
    // Obtener el parámetro 'idrecibo' desde la solicitud
    String idrecibo = request.getParameter("idrecibo");

    if (idrecibo != null) {
        try {
            // Parsear 'idrecibo' a un entero
            int idCobro = Integer.parseInt(idrecibo);

            // Primero, obtener el monto cobrado y el id de devolucion
            String selectSql = "SELECT monto_cobrado, iddevolucion FROM cobro_de_multa WHERE idcobro_multa = ?";
            PreparedStatement selectStmt = conn.prepareStatement(selectSql);
            selectStmt.setInt(1, idCobro); // Establecer el parámetro de consulta

            ResultSet rs = selectStmt.executeQuery();

            // Verificar si se obtuvieron resultados
            if (rs.next()) {
                int montoCobrado = rs.getInt("monto_cobrado"); // Usamos int para el monto
                int idDevolucion = rs.getInt("iddevolucion");

                // Actualizar la tabla devoluciones con el monto de la multa
                String updateDevolucionSql = "UPDATE devoluciones SET monto_multa = ? WHERE iddevolucion = ?";
                PreparedStatement updateDevolucionStmt = conn.prepareStatement(updateDevolucionSql);
                updateDevolucionStmt.setInt(1, montoCobrado); // Establecer el monto de la multa
                updateDevolucionStmt.setInt(2, idDevolucion);    // Establecer el ID de devolucion

                int filasAfectadasDevolucion = updateDevolucionStmt.executeUpdate();

                // Luego, actualizar la tabla cobro_de_multa para cambiar su estado
                String updateCobroSql = "UPDATE cobro_de_multa SET estado_co = 'Pendiente' WHERE idcobro_multa = ?";
                PreparedStatement updateCobroStmt = conn.prepareStatement(updateCobroSql);
                updateCobroStmt.setInt(1, idCobro); // Establecer el ID de cobro

                int filasAfectadasCobro = updateCobroStmt.executeUpdate();

                if (filasAfectadasDevolucion > 0 && filasAfectadasCobro > 0) {
                    out.print("Cobro regenerado exitosamente.");
                } else {
                    out.print("Error al regenerar el cobro o devoluciones.");
                }

            } else {
                out.print("No se encontró el cobro con el id proporcionado.");
            }

        } catch (NumberFormatException e) {
            // Manejo de la excepción si el parámetro no es un número válido
            out.print("El parámetro 'idrecibo' no es un número válido.");
        } catch (SQLException e) {
            // Manejo de la excepción de base de datos
            e.printStackTrace();
            out.print("Error al actualizar el estado del cobro.");
        }
    } else {
        out.print("El parámetro 'idrecibo' no fue proporcionado.");
    }
%>

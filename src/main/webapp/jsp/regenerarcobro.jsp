<%@ include file="conexion.jsp" %>
<%
    // Obtener el par�metro 'idrecibo' desde la solicitud
    String idrecibo = request.getParameter("idrecibo");

    if (idrecibo != null) {
        try {
            // Parsear 'idrecibo' a un entero
            int idCobro = Integer.parseInt(idrecibo);

            // Primero, obtener el monto cobrado y el id de devolucion
            String selectSql = "SELECT monto_cobrado, iddevolucion FROM cobro_de_multa WHERE idcobro_multa = ?";
            PreparedStatement selectStmt = conn.prepareStatement(selectSql);
            selectStmt.setInt(1, idCobro); // Establecer el par�metro de consulta

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
                out.print("No se encontr� el cobro con el id proporcionado.");
            }

        } catch (NumberFormatException e) {
            // Manejo de la excepci�n si el par�metro no es un n�mero v�lido
            out.print("El par�metro 'idrecibo' no es un n�mero v�lido.");
        } catch (SQLException e) {
            // Manejo de la excepci�n de base de datos
            e.printStackTrace();
            out.print("Error al actualizar el estado del cobro.");
        }
    } else {
        out.print("El par�metro 'idrecibo' no fue proporcionado.");
    }
%>

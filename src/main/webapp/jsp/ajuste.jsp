<%-- 
    Document   : ajuste
    Created on : 13 sept. 2024, 18:17:52
    Author     : david
--%>

<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
if (request.getParameter("listar").equals("listar")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT a.idajuste, a.cantidad_ajuste, a.idlibro, l.titulo_libro, a.fecha_ajuste FROM ajustes a INNER JOIN libros l ON a.idlibro = l.idlibro;");
        while (rs.next()) {
%>
<tr>
    <td><%out.print(rs.getString("idajuste"));%></td>
    <td><%out.print(rs.getString("cantidad_ajuste"));%></td>
    <td><%out.print(rs.getString("titulo_libro"));%></td>
    <td><%out.print(rs.getString("fecha_ajuste"));%></td>
    <td>
    <i class="bi bi-pencil-square" 
        onclick="rellenaredit('<%= rs.getString("idajuste").replace("'", "\\'") %>', 
                              '<%= rs.getString("cantidad_ajuste").replace("'", "\\'") %>', 
                              '<%= rs.getString("idlibro").replace("'", "\\'") %>', 
                              '<%= rs.getString("fecha_ajuste").replace("'", "\\'") %>')">
    </i>

</td>

</tr>
<%
        }
    } catch (Exception e) {
        out.println("Error PSQL: " + e);
    }
} 
    if (request.getParameter("listar").equals("modificar")) {
    String pk = request.getParameter("idajuste");
    String cantidad = request.getParameter("cantidad_ajuste");
    String libro = request.getParameter("idlibro"); // Cambia de idlibro a libro
    String fecha_ajuste = request.getParameter("fecha_ajuste");
    
    try {
        Statement st = null;
        st = conn.createStatement();
        // Actualiza el registro con el idajuste recibido
        st.executeUpdate("UPDATE ajustes SET cantidad_ajuste = '" + cantidad + "', idlibro = '" + libro + "', fecha_ajuste = '" + fecha_ajuste + "' WHERE idajuste = '" + pk + "'");
        out.println("<div class='alert alert-success alert-dismissible fade show' role='alert'>Datos actualizados con éxito!</div>");
    } catch (SQLException e) {
        out.println("Error PSQL: " + e);
    }
}


%>
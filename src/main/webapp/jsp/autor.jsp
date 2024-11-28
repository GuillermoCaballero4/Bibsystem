<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
if (request.getParameter("listar").equals("listar")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM autores");
        while (rs.next()) {
%>
<tr>
    <td><%out.print(rs.getString(1));%></td>
    <td><%out.print(rs.getString(2));%></td>
    <td><%out.print(rs.getString(3));%></td>
    <td><%out.print(rs.getString(4));%></td>
    <td>
        <i class="bi bi-pencil-square" onclick="rellenaredit('<%out.print(rs.getString(1));%>','<%out.print(rs.getString(2));%>','<%out.print(rs.getString(3));%>','<%out.print(rs.getString(4));%>')"></i>
        <i class="bi bi-x-circle" data-bs-toggle="modal" data-bs-target="#basicModal" onclick="$('#idautor').val('<%out.print(rs.getString(1));%>')"></i>
        <a target="blank_" href="datoautor.jsp?per=<%= rs.getString("idautor") %>" >
            <i class="bi bi-eye icono-negro"></i>
        </a> 
    </td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("Error PSQL: " + e);
    }
} else if (request.getParameter("listar").equals("cargar")) {
    String nombre = request.getParameter("nombre_autor");
    String apellido = request.getParameter("apellido_autor");
    String codigo = request.getParameter("codigo_autor");
    try {
        Statement st = null;
        st = conn.createStatement();
        st.executeUpdate("INSERT INTO autores (nombre_autor, apellido_autor,codigo_autor) VALUES ('"+nombre+"','"+apellido+"','"+codigo+"')");
        out.println("<div class='alert alert-success alert-dismissible fade show' role='alert'>Datos insertados con éxito!</div>");
    } catch (SQLException e) {
        out.println("Error PSQL: " + e);
    }
} else if (request.getParameter("listar").equals("modificar")) {
    String pk = request.getParameter("idautor");
    String nombre = request.getParameter("nombre_autor");
    String apellido = request.getParameter("apellido_autor");
    String codigo = request.getParameter("codigo_autor");
    try {
        Statement st = null;
        st = conn.createStatement();
        st.executeUpdate("UPDATE autores SET nombre_autor = '" + nombre + "', apellido_autor = '" + apellido + "', codigo_autor = '" + codigo + "' WHERE idautor = '" + pk + "'");
        out.println("<div class='alert alert-success' role='alert'>Datos modificados con éxito!</div>");
    } catch (SQLException e) {
        out.println("Error PSQL: " + e);
    }
} else if (request.getParameter("listar").equals("eliminar")) {
    String pk = request.getParameter("idpk");
    try {
        Statement st = null;
        st = conn.createStatement();
        st.executeUpdate("DELETE FROM autores WHERE idautor=" +pk+"");
        out.println("<div class='alert alert-success' role='alert'>Datos eliminados con éxito!</div>");
    } catch (SQLException e) {
        out.println("Error PSQL: " + e);
    }
}
%>

<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
if (request.getParameter("listar").equals("listar")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT l.idlibro, l.titulo_libro, c.nombre_categoria, l.idcategoria, l.idautor, l.descripcion_libro, a.nombre_autor, l.isbn " +
                             "FROM libros l " +
                             "INNER JOIN categorias c ON l.idcategoria = c.idcategoria " +
                             "INNER JOIN autores a ON l.idautor = a.idautor");
        while (rs.next()) {
%>
<tr>
    <td><%out.print(rs.getString("idlibro"));%></td>
    <td><%out.print(rs.getString("titulo_libro"));%></td>
    <td><%out.print(rs.getString("nombre_categoria"));%></td>
    <td><%out.print(rs.getString("descripcion_libro"));%></td>
    <td><%out.print(rs.getString("nombre_autor"));%></td>
    <td><%out.print(rs.getString("isbn"));%></td>
    <td>
        <i class="bi bi-pencil-square" onclick="rellenaredit('<%out.print(rs.getString("idlibro"));%>','<%out.print(rs.getString("titulo_libro"));%>','<%out.print(rs.getString("idcategoria"));%>','<%out.print(rs.getString("descripcion_libro"));%>','<%out.print(rs.getString("idautor"));%>','<%out.print(rs.getString("isbn"));%>')"></i>
        <i class="bi bi-x-circle" data-bs-toggle="modal" data-bs-target="#basicModal" onclick="$('#idlibro').val('<%out.print(rs.getString("idlibro"));%>')"></i>
        <a target="blank_" href="datolibro.jsp?per=<%= rs.getString("idlibro") %>" >
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
    String titulo = request.getParameter("titulo_libro");
    String idcategoria = request.getParameter("idcategoria");
    String descripcion = request.getParameter("descripcion_libro");
    String idautor = request.getParameter("idautor");
    String isbn = request.getParameter("isbn");

    // Verificar si el ISBN ya existe
    boolean isbnExistente = false;
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM libros WHERE isbn = '" + isbn + "'");
        if (rs.next()) {
            isbnExistente = true;
        }
        rs.close();
        st.close();
    } catch (SQLException e) {
        out.println("Error al verificar el ISBN: " + e);
    }

    if (isbnExistente) {
        out.println("<div class='alert alert-danger' role='alert'>El ISBN ya está registrado.</div>");
    } else {
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("INSERT INTO libros (titulo_libro, idcategoria, descripcion_libro, idautor, isbn) VALUES ('"+titulo+"','"+idcategoria+"','"+descripcion+"','"+idautor+"','"+isbn+"')");
            out.println("<div class='alert alert-success alert-dismissible fade show' role='alert'>Datos insertados con éxito!</div>");
        } catch (SQLException e) {
            out.println("Error PSQL al insertar libro: " + e);
        }
    }
} else if (request.getParameter("listar").equals("modificar")) {
    String pk = request.getParameter("idlibro");
    String titulo = request.getParameter("titulo_libro");
    String idcategoria = request.getParameter("idcategoria");
    String descripcion = request.getParameter("descripcion_libro");
    String idautor = request.getParameter("idautor");
    String isbn = request.getParameter("isbn");

    // Verificar si el ISBN ya existe (excluyendo el libro actual)
    boolean isbnExistente = false;
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM libros WHERE isbn = '" + isbn + "' AND idlibro <> '" + pk + "'");
        if (rs.next()) {
            isbnExistente = true;
        }
        rs.close();
        st.close();
    } catch (SQLException e) {
        out.println("Error al verificar el ISBN: " + e);
    }

    if (isbnExistente) {
        out.println("<div class='alert alert-danger' role='alert'>El ISBN ya está registrado.</div>");
    } else {
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("UPDATE libros SET titulo_libro = '" + titulo + "', idcategoria = '" + idcategoria + "', descripcion_libro = '" + descripcion + "', idautor = '" + idautor + "', isbn = '" + isbn + "' WHERE idlibro = '" + pk + "'");
            out.println("<div class='alert alert-success' role='alert'>Datos modificados con éxito!</div>");
        } catch (SQLException e) {
            out.println("Error PSQL al modificar libro: " + e);
        }
    }
} else if (request.getParameter("listar").equals("eliminar")) {
    String pk = request.getParameter("idpk");
    try {
        Statement st = null;
        st = conn.createStatement();
        st.executeUpdate("DELETE FROM libros WHERE idlibro=" + pk + "");
        out.println("<div class='alert alert-success' role='alert'>Datos eliminados con éxito!</div>");
    } catch (SQLException e) {
        out.println("Error PSQL al eliminar libro: " + e);
    }
}
%>

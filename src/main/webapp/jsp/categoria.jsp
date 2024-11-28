
<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
if (request.getParameter("listar").equals("listar")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM categorias");
        while (rs.next()) {
%>
<tr>
    <td><%out.print(rs.getString("idcategoria"));%></td>
    <td><%out.print(rs.getString("nombre_categoria"));%></td>
    <td>
        <i class="bi bi-pencil-square" onclick="rellenaredit('<%out.print(rs.getString("idcategoria"));%>','<%out.print(rs.getString("nombre_categoria"));%>')"></i>
        <i class="bi bi-x-circle" data-bs-toggle="modal" data-bs-target="#basicModal" onclick="$('#idcategoria').val('<%out.print(rs.getString("idcategoria"));%>')"></i>
        <a target="blank_" href="datocategoria.jsp?per=<%= rs.getString("idcategoria") %>" >
            <i class="bi bi-eye icono-negro"></i>
        </a> 
    </td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("Error PSQL: " + e);
    }
} if (request.getParameter("listar").equals("cargar")) {
    String nombre = request.getParameter("nombre_categoria");
    boolean cat = false;
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM categorias WHERE nombre_categoria = '" + nombre + "'");

        while (rs.next()) {
            cat = true;
        }

        rs.close();
        st.close();
    } catch (SQLException e) {
        out.println("Error al verificar datos: " + e);
    }

    if (cat) {
        out.println("<div class='alert alert-danger' role='alert'>El nombre de la categoria ya existe.</div>");
    } else {
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("INSERT INTO categorias (nombre_categoria) VALUES ('" + nombre + "')");
            out.println("<div class='alert alert-success alert-dismissible fade show' role='alert'>Datos insertados con éxito!</div>");
        } catch (SQLException e) {
            out.println("Error PSQL: " + e);
        }
    }
}
 else if (request.getParameter("listar").equals("modificar")) {
    String pk = request.getParameter("idcategoria");
    String nombre = request.getParameter("nombre_categoria");
    try {
        Statement st = null;
        st = conn.createStatement();
        st.executeUpdate("UPDATE categorias SET nombre_categoria = '" + nombre + "' WHERE idcategoria = '" + pk + "'");
        out.println("<div class='alert alert-success' role='alert'>Datos modificados con éxito!</div>");
    } catch (SQLException e) {
boolean cat = false;
    

        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM categorias WHERE nombre_categoria = '" + nombre + "'");


        while (rs.next()) {
            
                cat = true;
            
        }
if (cat) {
        out.println("<div class='alert alert-danger' role='alert'>El nombre de categoria ya existe.</div>");
    }else {
            out.println("Error PSQL: " + e);
} 
            
        }
} else if (request.getParameter("listar").equals("eliminar")) {
    String pk = request.getParameter("idpk");
    try {
        Statement st = null;
        st = conn.createStatement();
        st.executeUpdate("DELETE FROM categorias WHERE idcategoria=" +pk+"");
        out.println("<div class='alert alert-success' role='alert'>Datos eliminados con éxito!</div>");
    } catch (SQLException e) {
        out.println("Error PSQL: " + e);
    }
}
%>

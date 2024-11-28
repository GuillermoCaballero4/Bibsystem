<%-- 
    Document   : metodo
    Created on : 24 nov. 2024, 16:03:17
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
        rs = st.executeQuery("SELECT * FROM metodo_de_de_pago");
        while (rs.next()) {
%>
<tr>
    <td><%out.print(rs.getString("idmetododepago"));%></td>
    <td><%out.print(rs.getString("descripcion"));%></td>
    <td>
        <i class="bi bi-pencil-square" onclick="rellenaredit('<%out.print(rs.getString("idmetododepago"));%>','<%out.print(rs.getString("descripcion"));%>')"></i>
        <i class="bi bi-x-circle" data-bs-toggle="modal" data-bs-target="#basicModal" onclick="$('#idmetododepago').val('<%out.print(rs.getString("idmetododepago"));%>')"></i>
        <a target="blank_" href="datometodo.jsp?per=<%= rs.getString("idmetododepago") %>" >
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
    String descripcion = request.getParameter("descripcion");
    boolean cat = false;
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM metodo_de_de_pago WHERE descripcion = '" + descripcion + "'");

        while (rs.next()) {
            cat = true;
        }

        rs.close();
        st.close();
    } catch (SQLException e) {
        out.println("Error al verificar datos: " + e);
    }

    if (cat) {
        out.println("<div class='alert alert-danger' role='alert'>La descripcion ya existe.</div>");
    } else {
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("INSERT INTO metodo_de_de_pago (descripcion) VALUES ('" + descripcion + "')");
            out.println("<div class='alert alert-success alert-dismissible fade show' role='alert'>Datos insertados con éxito!</div>");
        } catch (SQLException e) {
            out.println("Error PSQL: " + e);
        }
    }
}
else if (request.getParameter("listar").equals("modificar")) {
    String pk = request.getParameter("idmetododepago");
    String descripcion = request.getParameter("descripcion");
    boolean cat = false;

    try {
        Statement st = null;
        ResultSet rs = null;

        // Consultar si la descripción ya existe
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM metodo_de_de_pago WHERE descripcion = '" + descripcion + "'");

        while (rs.next()) {
            cat = true;
        }

        if (cat) {
            out.println("<div class='alert alert-danger' role='alert'>Esa descripcion ya existe.</div>");
        } else {
            // Realizar el UPDATE si no hay duplicados
            st.executeUpdate("UPDATE metodo_de_de_pago SET descripcion = '" + descripcion + "' WHERE idmetododepago = '" + pk + "'");
            out.println("<div class='alert alert-success' role='alert'>Datos modificados con éxito!</div>");
        }
    } catch (SQLException e) {
        out.println("<div class='alert alert-danger' role='alert'>Error PSQL: " + e + "</div>");
    }
}
 else if (request.getParameter("listar").equals("eliminar")) {
    String pk = request.getParameter("idpk");
    try {
        Statement st = null;
        st = conn.createStatement();
        st.executeUpdate("DELETE FROM metodo_de_de_pago WHERE idmetododepago=" +pk+"");
        out.println("<div class='alert alert-success' role='alert'>Datos eliminados con éxito!</div>");
    } catch (SQLException e) {
        out.println("Error PSQL: " + e);
    }
}
%>


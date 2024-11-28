
<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("SELECT u.idusuario, u.nombre_usu, u.idpersonal, u.clave_usu, p.nombre_personal  FROM usuarios u INNER JOIN personales p ON u.idpersonal = p.idpersonal;");
            while (rs.next()) {
%>
<tr>
    <td><%out.print(rs.getString(1));%></td>
    <td><%out.print(rs.getString(2));%></td>
    <td><%out.print(rs.getString(4));%></td>
    <td><%out.print(rs.getString("nombre_personal"));%></td>
    
    <td><i class="bi bi-pencil-square" onclick="rellenaredit('<%out.print(rs.getString(1));%>','<%out.print(rs.getString(2));%>','<%out.print(rs.getString(4));%>','<%out.print(rs.getString(3));%>')"></i> <i class="bi bi-x-circle" data-bs-toggle="modal" data-bs-target="#basicModal" onclick="$('#idusuario').val('<%out.print(rs.getString(1));%>')"></i>
         <a target="blank_" href="datousuario.jsp?per=<%= rs.getString("idusuario") %>" >
            <i class="bi bi-eye icono-negro"></i>
        </a> 
</td>
</tr>
<%
            }
        } catch (Exception e) {
            out.println("error PSQL" + e);
        }
}if (request.getParameter("listar").equals("cargar")) {
    String nombre = request.getParameter("nombre_usu");
    String clave = request.getParameter("clave_usu");
    String idpersonal = request.getParameter("idpersonal");

    boolean nombreUsuExiste = false;
    boolean claveUsuExiste = false;

    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM usuarios WHERE nombre_usu = '" + nombre + "'");

        while (rs.next()) {
            
                nombreUsuExiste = true;
            
        }

        rs.close();
        st.close();
    } catch (SQLException e) {
        out.println("Error al verificar datos: " + e);
    }

      if (nombreUsuExiste) {
        out.println("<div class='alert alert-danger' role='alert'>El nombre de usuario ya existe. Por favor, ingrese un nombre de usuario válido.</div>");
    } else {
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("INSERT INTO usuarios (nombre_usu, clave_usu, idpersonal) VALUES ('" + nombre + "','" + clave + "','" + idpersonal + "')");

            out.println("<div class='alert alert-success' role='alert'>Datos insertados con éxito!</div>");

            st.close();
        } catch (SQLException e) {

            out.println("Error al insertar datos: " + e);
        }
    }
}
else if (request.getParameter("listar").equals("modificar")) {
        String pk = request.getParameter("idusuario");
        String nombre = request.getParameter("nombre_usu");
        String clave = request.getParameter("clave_usu");
        String idpersonal = request.getParameter("idpersonal");
        
        
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("update usuarios set nombre_usu = '" + nombre + "', clave_usu = '" + clave + "', idpersonal = '" + idpersonal + "' where idusuario = '" + pk + "'");
            out.println("<div class='alert alert-success' role='alert'> Datos modificados  con éxito!</div>");
            }
catch (SQLException e) {
boolean nombreUsuExiste = false;
    boolean claveUsuExiste = false;

        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM usuarios WHERE nombre_usu = '" + nombre + "'");

        while (rs.next()) {
            
                nombreUsuExiste = true;
            
        }
if (nombreUsuExiste) {
        out.println("<div class='alert alert-danger' role='alert'>El nombre de usuario ya existe. Por favor, ingrese un nombre de usuario válido.</div>");
    }else {
            out.println("Error PSQL: " + e);
} 
            
        }
        } 
else if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("idpk");
        try {
          Statement st = null;
          st = conn.createStatement();
          st.executeUpdate("delete from usuarios where idusuario=" +pk+"");
          out.println("<div class='alert alert-success' role='alert'> Datos eliminados  con éxito!</div>");
        } catch (SQLException e) {
            out.println("Error PSQL: " + e);
        }
    }
%>
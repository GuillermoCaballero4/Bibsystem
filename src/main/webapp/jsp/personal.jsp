
<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM personales");
            while (rs.next()) {
%>
<tr>
    <td><%out.print(rs.getString(1));%></td>
    <td><%out.print(rs.getString(2));%></td>
    <td><%out.print(rs.getString(3));%></td>
    <td><%out.print(rs.getString(4));%></td>
    <td><%out.print(rs.getString(5));%></td>
    <td><i class="bi bi-pencil-square" onclick="rellenaredit('<%out.print(rs.getString(1));%>','<%out.print(rs.getString(2));%>','<%out.print(rs.getString(3));%>','<%out.print(rs.getString(4));%>','<%out.print(rs.getString(5));%>')"></i> <i class="bi bi-x-circle" data-bs-toggle="modal" data-bs-target="#basicModal" onclick="$('#idpersona').val('<%out.print(rs.getString(1));%>')"></i>
         <a target="blank_" href="datopersonales.jsp?per=<%= rs.getString("idpersonal") %>" >
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
    String nombre = request.getParameter("nombre_personal");
    String apellido = request.getParameter("apellido_personal");
    String ci = request.getParameter("ci_personal");
    String telefono = request.getParameter("telefono_personal");

    boolean ciExiste = false;
    boolean teExiste = false;

    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM personales WHERE ci_personal = '" + ci + "' OR telefono_personal = '" + telefono + "'");

        while (rs.next()) {
            if (ci.equals(rs.getString("ci_personal"))) {
                ciExiste = true;
            }
            if (telefono.equals(rs.getString("telefono_personal"))) {
                teExiste = true;
            }
        }

        rs.close();
        st.close();
    } catch (SQLException e) {
        out.println("Error al verificar datos: " + e);
    }

    if (ciExiste && teExiste) {
        out.println("<div class='alert alert-danger' role='alert'>El número de CI y de Teléfono ya existen. Por favor, ingrese datos válidos.</div>");
    } else if (ciExiste) {
        out.println("<div class='alert alert-danger' role='alert'>El número de CI ya existe. Por favor, ingrese un número de CI válido.</div>");
    } else if (teExiste) {
        out.println("<div class='alert alert-danger' role='alert'>El número de Teléfono ya existe. Por favor, ingrese un número de teléfono válido.</div>");
    } else {
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("INSERT INTO personales (nombre_personal, apellido_personal, ci_personal, telefono_personal) VALUES ('" + nombre + "','" + apellido + "','" + ci + "','" + telefono + "')");

            out.println("<div class='alert alert-success' role='alert'>Datos insertados con éxito!</div>");

            st.close();
        } catch (SQLException e) {
            out.println("Error al insertar datos: " + e);
        }
    }
}
 else if (request.getParameter("listar").equals("modificar")) {
        String pk = request.getParameter("idpersonal");
        String nombre = request.getParameter("nombre_personal");
        String apellido = request.getParameter("apellido_personal");
        String ci = request.getParameter("ci_personal");
        String telefono = request.getParameter("telefono_personal");
        
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("update personales set nombre_personal = '" + nombre + "', apellido_personal = '" + apellido + "', ci_personal = '" + ci + "', telefono_personal = '" + telefono + "' where idpersonal = '" + pk + "'");
            out.println("<div class='alert alert-success' role='alert'> Datos modificados  con éxito!</div>");
            }
catch (SQLException e) {

            boolean ciExiste = false;
         boolean teExiste = false;
Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM personales WHERE ci_personal = '" + ci + "' OR telefono_personal = '" + telefono + "'");

        while (rs.next()) {
            if (ci.equals(rs.getString("ci_personal"))) {
                ciExiste = true;
            }
            if (telefono.equals(rs.getString("telefono_personal"))) {
                teExiste = true;
            }
        }
if(ciExiste && teExiste){
out.println("<div class='alert alert-danger' role='alert'>El número de CI y de Teléfono ya existen. Por favor, ingrese datos válidos.</div>");
}   else if (ciExiste) {
        out.println("<div class='alert alert-danger' role='alert'>El número de CI ya existe. Por favor, ingrese un número de CI válido.</div>");
    }else if (teExiste){
    out.println("<div class='alert alert-danger' role='alert'>El número de Telefono ya existe. Por favor, ingrese un número de telefono válido.</div>");
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
          st.executeUpdate("delete from personales where idpersonal=" +pk+"");
          out.println("<div class='alert alert-success' role='alert'> Datos eliminados  con éxito!</div>");
        } catch (SQLException e) {
            out.println("Error PSQL: " + e);
        }
    }
%>

<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM personas");
            while (rs.next()) {
%>
<tr>
    <td><%out.print(rs.getString(1));%></td>
    <td><%out.print(rs.getString(2));%></td>
    <td><%out.print(rs.getString(3));%></td>
    <td><%out.print(rs.getString(4));%></td>
    <td><%out.print(rs.getString(5));%></td>
    <td><i class="bi bi-pencil-square" onclick="rellenaredit('<%out.print(rs.getString(1));%>','<%out.print(rs.getString(2));%>','<%out.print(rs.getString(3));%>','<%out.print(rs.getString(4));%>','<%out.print(rs.getString(5));%>')"></i> <i class="bi bi-x-circle" data-bs-toggle="modal" data-bs-target="#basicModal" onclick="$('#idpersona').val('<%out.print(rs.getString(1));%>')"></i>
        <a target="blank_" href="datopersona.jsp?per=<%= rs.getString("idpersona") %>" >
            <i class="bi bi-eye icono-negro"></i>
        </a>     
    </td>
</tr>
<%
            }
        } catch (Exception e) {
            out.println("error PSQL" + e);
        }
}else if (request.getParameter("listar").equals("cargar")) {
    String nombre = request.getParameter("nombre_persona");
    String apellido = request.getParameter("apellido_persona");
    String ci = request.getParameter("ci_persona");
    String telefono = request.getParameter("telefono_persona");

    boolean ciExiste = false;
    boolean teExiste = false;
    
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM personas WHERE ci_persona = '" + ci + "' or telefono_persona = '"+telefono+"' ");
        
        while (rs.next()) {
            if (ci.equals(rs.getString("ci_persona"))) {
                ciExiste = true;
            }
            if (telefono.equals(rs.getString("telefono_persona"))) {
                teExiste = true;
            }
        }

        rs.close();
        st.close();
    } catch (SQLException e) {
        out.println("Error al verificar datos: " + e);
    }
    if(ciExiste && teExiste){
out.println("<div class='alert alert-danger' role='alert'>El número de CI y de Teléfono ya existen. Por favor, ingrese datos válidos.</div>");
}   else if (ciExiste) {
        out.println("<div class='alert alert-danger' role='alert'>El número de CI ya existe. Por favor, ingrese un número de CI válido.</div>");
    }else if (teExiste){
    out.println("<div class='alert alert-danger' role='alert'>El número de Telefono ya existe. Por favor, ingrese un número de telefono válido.</div>");
}else {
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("INSERT INTO personas (nombre_persona, apellido_persona, ci_persona, telefono_persona) VALUES ('" + nombre + "','" + apellido + "','" + ci + "','" + telefono + "')");

            out.println("<div class='alert alert-success' role='alert'>Datos insertados con éxito!</div>");

            st.close();
        } catch (SQLException e) {
            out.println("Error al insertar datos: " + e);
        }
    }
}
 else if (request.getParameter("listar").equals("modificar")) {
        String pk = request.getParameter("idpersona");
        String nombre = request.getParameter("nombre_persona");
        String apellido = request.getParameter("apellido_persona");
        String ci = request.getParameter("ci_persona");
        String telefono = request.getParameter("telefono_persona");
       
        try {
            Statement st = null;
            st = conn.createStatement();
            st.executeUpdate("update personas set nombre_persona = '" + nombre + "', apellido_persona = '" + apellido + "', ci_persona = '" + ci + "', telefono_persona = '" + telefono + "' where idpersona = '" + pk + "'");
            out.println("<div class='alert alert-success' role='alert'> Datos modificados  con éxito!</div>");
            
}

catch (SQLException e) {
  boolean ciExiste = false;
         boolean teExiste = false;
Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM personas WHERE ci_persona = '" + ci + "' or telefono_persona = '"+telefono+"'");
        
 while (rs.next()) {
            if (ci.equals(rs.getString("ci_persona"))) {
                ciExiste = true;
            }
            if (telefono.equals(rs.getString("telefono_persona"))) {
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
} }

        } 
else if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("idpk");
        try {
          Statement st = null;
          st = conn.createStatement();
          st.executeUpdate("delete from personas where idpersona=" +pk+"");
          out.println("<div class='alert alert-success' role='alert'> Datos eliminados  con éxito!</div>");
        } catch (SQLException e) {
            out.println("Error PSQL: " + e);
        }
    }
%>
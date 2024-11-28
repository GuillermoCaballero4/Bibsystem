    <%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>

<%
    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT idpersona, nombre_persona, ci_persona FROM personas");
%>
<option value="">Seleccionar Persona</option>
<%
    while (rs.next()) {
        String nombrePersona = rs.getString("nombre_persona");
        String ciPersona = rs.getString("ci_persona");
        int idPersona = rs.getInt("idpersona");
%>
<option value="<%= idPersona %>" data-ci="<%= ciPersona %>">
    <%= nombrePersona %> - CI: <%= ciPersona %>
</option>
<%
    }
} catch (Exception e) {
    e.printStackTrace();
}
%>


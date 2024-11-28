<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>
<%@include file="conexion.jsp"%>
<%-- 
    Document   : Login
    Created on : 14 jul. 2024, 15:20:43
    Author     : David
--%>

<%
    String user = request.getParameter("nombre_usu");
    String password = request.getParameter("clave_usu");

    HttpSession sesion = request.getSession();
    Statement st = null;
    ResultSet rs = null;

    boolean loginSuccess = false; // Variable para verificar el éxito del inicio de sesión

    try {
        st = conn.createStatement();
        rs = st.executeQuery("SELECT idusuario, nombre_usu FROM usuarios WHERE nombre_usu='" + user + "' AND clave_usu='" + password + "';");

        if (rs.next()) { // Cambiado a if para evitar el while
            sesion.setAttribute("logueado", "1");
            sesion.setAttribute("idusuario", rs.getString("idusuario"));
            sesion.setAttribute("user", rs.getString("nombre_usu"));
            loginSuccess = true; // El inicio de sesión fue exitoso

            // Redireccionar a dashboard
            %>
            <script>location.href='dashboard.jsp';</script>
            <%
        }
    } catch (Exception e) {
        out.print("<div class=\"alert alert-danger\" role=\"alert\">Error: " + e.getMessage() + "</div>");
    }

    // Mostrar mensaje de error solo si el inicio de sesión no fue exitoso
    if (!loginSuccess) {
        out.println("<div class=\"alert alert-danger\" role=\"alert\">Usuario no válido</div>");
    }
%>

/*INCLUIR LIBRERIAS PARA GENERAR SESSIONES*/


<%@page import="java.math.BigInteger"%>/*SIRVE PARA LUEGO GENERAR LA FUNCION MD5*/
<%@page import="java.security.MessageDigest"%>/*SIRVE PARA LA SEGURIDAD DEL LOGIN*/




/*GENERAR SESSION*/


<%                                   
Statement st = null;
ResultSet rs = null;

if (request.getParameter("btnLogin") != null) {

/*Tomamos los parametros del HTML*/
String user = request.getParameter("usuario");
String password = request.getParameter("pswrd");

/*Instanciamos para crear nuestras sesiones*/
HttpSession sesion = request.getSession();

try {
                                           
st = conn.createStatement();
rs = st.executeQuery("SELECT * FROM usuarios  where usuario='" + user + "' and contra='" + password + "';");
while (rs.next()) {
sesion.setAttribute("logueado", "1");
sesion.setAttribute("user", rs.getString("usuario"));
sesion.setAttribute("id", rs.getString("id"));
response.sendRedirect("index.jsp");
}
out.println("<div class=\"alert alert-danger\" role=\"alert\">Usuario no valido</div>");
} catch (Exception e) {
out.print(e.getMessage());
}
}
%>  


/*MOSTRAR VALORES DE LAS VARIABLES DE SESSION*/
<% out.print(sesion.getAttribute("user")); %>

/*VERIFICAR SI TENEMOS UNA SESSION ABIERTA*/

<%
HttpSession sesion = request.getSession();
if (sesion.getAttribute("logueado") == null || sesion.getAttribute("logueado").equals("0")) {
%>
<script>alert('Ud. debe de identificarse..!!');</script>
<%
response.sendRedirect("login.jsp");
                
                
}else{
             
%>
		
mostrar el HTML/BODY del index
		
<% } %>
		
/*ELIMINAR BORRAR LA SESSION*/		

<%
HttpSession sesion=request.getSession();
sesion.invalidate();
response.sendRedirect("login.jsp");
%>
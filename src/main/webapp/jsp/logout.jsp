<%-- 
    Document   : logout
    Created on : 14 jul. 2024, 15:23:12
    Author     : david
--%>
<%
HttpSession sesion=request.getSession();
sesion.invalidate();

response.sendRedirect("../index.jsp");
%>
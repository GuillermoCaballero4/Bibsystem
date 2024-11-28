<%-- 
    Document   : consultametodo
    Created on : 24 nov. 2024, 16:58:38
    Author     : david
--%>
<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>

<%
    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT idmetododepago, descripcion FROM public.metodo_de_de_pago;");
%>

<select name="idmetododepago" id="metodoPago" class="select2 form-control">
    <option value="" disabled selected>Seleccione un método de pago</option>
    
    <% 
        while (rs.next()) {
            int idmetododepago = rs.getInt("idmetododepago");
            
            String descripcion = rs.getString("descripcion");
    %>
    <option value="<%= idmetododepago %>"  data-select2-id="<%= idmetododepago %>"><%= descripcion %></option>
    <% 
        }
    %>
</select>   





<%
    } catch (SQLException e) {
        out.println("Error SQL: " + e.getMessage());
    } catch (Exception e) { %>
<% out.println("Error general: " + e.getMessage()); %>
<% } %>



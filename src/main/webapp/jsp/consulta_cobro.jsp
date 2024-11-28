<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>

<%
    try {
        Statement st = conn.createStatement();
       
ResultSet rs = st.executeQuery(
    " SELECT cob.idcobro_multa, cob.iddevolucion, cob.monto_cobrado, cob.idusuario, per.idpersona, per.nombre_persona, dev.monto_multa, dev.motivo_multa, cob.fecha_co AS fecha_cobro, cob.estado_co "+
    " FROM devoluciones dev "+ 
    " LEFT JOIN cobro_de_multa cob ON cob.iddevolucion = dev.iddevolucion "+
    " LEFT JOIN prestamos pr ON pr.idprestamo = dev.idprestamo "+
    " LEFT JOIN reservas r ON r.idreserva = pr.idreserva "+
    " LEFT JOIN personas per ON per.idpersona = r.idpersona "+ 
    " WHERE "+
    " dev.motivo_multa <> '' "+
    " AND dev.monto_multa IS NOT NULL "
    
);


        while (rs.next()) {
            int idusuario = rs.getInt("idusuario");
            String idpersona = rs.getString("idpersona");
            String iddevolucion = rs.getString("iddevolucion");
            String nombre_persona = rs.getString("nombre_persona");
            int monto_multa = rs.getInt("monto_multa");
            String motivo_multa = rs.getString("motivo_multa");
            String monto_cobrado = rs.getString("monto_cobrado");
            String fecha_cobro = rs.getString("fecha_cobro");
          String estado_co = rs.getString("estado_co");
          int idcobro_multa = rs.getInt("idcobro_multa");
          
%>
            <tr>
                <td><%= nombre_persona %></td>
                <td><%= monto_multa %></td>
                <td><%= motivo_multa %></td>
                <td><%= fecha_cobro != null ? fecha_cobro : "N/A" %></td>
                <td><%= estado_co %></td>
                <td>
                    <%
                    if(rs.getString("estado_co").equals("Pendiente")){
                    %>
                    
                          <button class="btn btn-outline-primary"  onclick="abrirModalCobro('<%= idpersona %>', '<%= nombre_persona %>', '<%= iddevolucion %>','<%= monto_multa %>','<%= idcobro_multa %>')">Cobrar</button>
                    <%
                          }else{%>
                           <button class="btn btn-outline-primary" disabled  >Cobrar</button>
                          
 <%
 }
                    %> 
                    <%
                    if(rs.getString("estado_co").equals("Cobrado")){
                    %>
                    <i class="btn btn-outline-success">
                           <a clas target="_blank" href="datocobra.jsp?per=<%= rs.getString("idcobro_multa") %>&monto_cobrado=<%= rs.getString("monto_cobrado") %>">
                    <%
                          }else{%>
 <%
 }
                    %> 
                  
Imprimir Recibo
            </i>
        </a>
                   
                    <%
  String estado = rs.getString("estado_co");
  String valorRecibo = rs.getString(1);
%>
  <i class="btn btn-outline-danger" 
   data-bs-toggle="modal" 
   data-bs-target="#modalanular" 
   onclick="<%= estado.equals("Anulado") ? "" : "$('#idanular').val('" + valorRecibo + "');" %>"
   <%= estado.equals("Anulado") ? "style='pointer-events: none; color: #ccc;'" : "" %>>
   Anular
</i>
<!-- Condicionalmente deshabilitar el enlace si no está "Anulado" -->
<i class="btn btn-outline-dark" 
     data-bs-toggle="modal" 
   data-bs-target="#modalregenerar" 
   
   onclick="<%= estado.equals("Anulado") ? "$('#idrecibo').val('" + valorRecibo + "');" : "return false;" %>"
   <%= estado.equals("Anulado") ? "" : "style='pointer-events: none; color: #ccc;'" %>
>
   Regenerar cobro  
</i>
                    
                </td>
            </tr>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

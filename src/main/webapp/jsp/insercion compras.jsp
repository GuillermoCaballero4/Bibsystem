<%@include file="conexion.jsp"%>
<%    if (request.getParameter("listar").equals("cargar")) {

        /*DATOS PARA LA CABECERA*/
        //idproveedor
        //fecha
        /*DATOS PARA EL DETALLE*/
        //idproducto
        //cantidad
        //precio
        String codproveedor = request.getParameter("codproveedor");
        String fecharegistro = request.getParameter("fecharegistro");
        String codproducto = request.getParameter("codproducto");
        String cantidad = request.getParameter("cantidad");
        String precio = request.getParameter("precio");
        //out.println(codproveedor + ',' + fecharegistro + ',' + codproducto + ',' + cantidad + ',' + precio);
        try {
            Statement st = null;
            ResultSet rs = null;
            ResultSet pk = null;
            st = conn.createStatement();
            rs = st.executeQuery("SELECT id FROM compras where estado='Pendiente';");
            if (rs.next()) {
                //out.println("Existe cabecera");
                st.executeUpdate("insert into detallecompras (idcompra,idproducto,cantidad,precio)values('" + rs.getString(1) + "','" + codproducto + "','" + cantidad + "','" + precio + "')");
            } else {
                //out.println("NO existe cabecera");

                st.executeUpdate("insert into compras (idproveedor,fecha)values('" + codproveedor + "','" + fecharegistro + "')");
                pk = st.executeQuery("SELECT id FROM compras where estado='Pendiente';");
                pk.next();
                st.executeUpdate("insert into detallecompras (idcompra,idproducto,cantidad,precio)values('" + pk.getString(1) + "','" + codproducto + "','" + cantidad + "','" + precio + "')");
            }

        } catch (Exception e) {
            out.println("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            ResultSet pk = null;
            st = conn.createStatement();
            pk = st.executeQuery("SELECT id FROM compras where estado='Pendiente';");
            pk.next();
            rs = st.executeQuery("select dt.id,p.descripcion,dt.cantidad, dt.precio from detallecompras dt, productos p where dt.idproducto=p.id and dt.idcompra='" + pk.getString(1) + "'");
            while (rs.next()) {
                String cantidad = rs.getString(3);
                String precio = rs.getString(4);
                Integer cantidad1 = Integer.parseInt(cantidad);
                Integer precio1 = Integer.parseInt(precio);
                int calcular = cantidad1 * precio1;
%>
<tr>
    <td><i class="fa fa-trash" data-bs-target="#exampleModal"></i></td>
    <td><%out.print(rs.getString(2));%></td>
    <td><%out.print(rs.getString(3));%></td>
    <td><%out.print(rs.getString(4));%></td>
    <td><%out.print(calcular);%></td>

</tr>
<%}
        } catch (Exception e) {
            out.println("error PSQL" + e);
        }
    }

%>
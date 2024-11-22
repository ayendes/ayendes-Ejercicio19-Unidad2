<%-- 
    Document   : buscar_editar_borrar
    Created on : 5/11/2024, 4:31:27 p. m.
    Author     : Abraham Yendes
--%>

<%@page import="Domain.Model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buscar, Editar o Eliminar Usuario</title>
        <script>
            function enableButtons(){
                document.getElementById("editarBtn").disabled = false;
                document.getElementById("eliminarBtn").disabled = false;
            }
            
            function disableButtons(){
                document.getElementById("editarBtn").disabled = true;
                document.getElementById("eliminarBtn").disabled = true;
            }
            
            function setActionAndSubmit(action, confirmMessage){
                if (confirmMessage){
                    if (!confirm(confirmMessage)){
                       return; 
                    }
                }
                document.getElementById("actionInput").value = action;
                document.getElementById("usuarioForm").submit();
            }
        </script>
    </head>
    <body onload="<%= (session.getAttribute("buscarUsuario")!= null) ? "enableButtons()" : "disableButtons()"%>">
        <h1>Buscar, Editar o Eliminar Usuario</h1>
        <% if (request.getAttribute("errorMessage") != null) { %>
        <p style ="color:red;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
        <% if (request.getAttribute("successMessage") != null) { %>
        <p style ="color:green;"><%= request.getAttribute("successMessage") %></p>
        <% } %>
        <%-- Formulario --%>
        <form id="usuarioForm" action="<%= request.getContextPath() %>/Controllers/UsuarioControllers.jsp" method="post">
            <input type="hidden" id="actionInput" name="action" value="buscar">
            <label for="buscarId">Codigo de Usuario:</label><br>
            <input type="text" id="id" name="id" required value="<%= session.getAttribute("buscarUsuario")!= null ? ((Usuario)session.getAttribute("buscarUsuario")).getId() : "" %>">
            <br><br>
            <% Usuario sessionUsuario = (Usuario) session.getAttribute("buscarUsuario");%>
            <% if(sessionUsuario != null) {%>
            <h3>Informacion de Usuario</h3>
            <p><strong>Id</strong> <%= sessionUsuario.getId() %></p>
            <p><strong>Password</strong> <%= sessionUsuario.getPassword() %></p>
            <p><strong>Nombre</strong> <%= sessionUsuario.getNombre() %></p>
            <p><strong>Apellidos</strong> <%= sessionUsuario.getApellidos() %></p>
            <p><strong>Rol</strong> <%= sessionUsuario.getRol() %></p>
            <p><strong>Email</strong> <%= sessionUsuario.getEmail() %></p>
            <p><strong>Telefono</strong> <%= sessionUsuario.getTelefono() %></p>
            <p><strong>Estado</strong> <%= sessionUsuario.getEstado() %></p>
            <p><strong>Fecha Registro</strong> <%= sessionUsuario.getFecha_registro() %></p>
            
            <label for="password">Nuevo Password</label><br>
            <input type="password" id="password" name="password" value="<%= sessionUsuario.getNombre() %>" required>
            <br>
            <br>
            
            <label for="name">Nuevo Nombre</label><br>
            <input type="text" id="name" name="name" value="<%= sessionUsuario.getNombre() %>" required>
            <br>
            <br>
            
            <label for="apellidos">Nuevo Apellidos</label><br>
            <input type="text" id="apellidos" name="apellidos" value="<%= sessionUsuario.getApellidos() %>" required>
            <br>
            <br>
            
            <label for="email">Nuevo Email</label><br>
            <input type="email" id="email" name="email" value="<%= sessionUsuario.getEmail() %>" required>
            <br>
            <br>
            
            <label for="telefono">Nuevo Telefono</label><br>
            <input type="tel" id="telefono" name="telefono" value="<%= sessionUsuario.getTelefono() %>" required>
            <br>
            <br>
            
            <label for="estado">Nuevo Estado</label><br>
            <input type="text" id="estado" name="estado" value="<%= sessionUsuario.getEstado() %>" required>
            <% } else {%>
            <p>No se consultado o el usuario no existe</p>
            <% }%>
            <br>
            
            <button type="submit" onclick="setActionAndSubmit('buscar')" id="buscarBtn">Buscar Usuario</button>
            <button type="button" id= "editarBtn" disabled onclick="setActionAndSubmit('actualizar', '¿Seguro que desea editar este usuario?')" >Editar Usuario</button>
            <button type="button" id= "eliminarBtn" disabled onclick="setActionAndSubmit('eliminar', '¿Seguro que desea eliminar este usuario?')" >Eliminar Usuario</button>
        </form>
            <br>
            <a href="<%= request.getContextPath() %>/index.jsp">Menú Principal</a>
    </body>
</html>

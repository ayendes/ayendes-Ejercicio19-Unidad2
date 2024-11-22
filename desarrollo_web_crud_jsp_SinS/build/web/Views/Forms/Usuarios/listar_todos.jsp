<%-- 
    Document   : listar_todos
    Created on : 5/11/2024, 4:31:51 p. m.
    Author     : Abraham Yendes
--%>

<%@page import="java.util.List"%>
<%@page import="Domain.Model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Usuarios</title>
    </head>
    <body>
        <h1>Lista de Todos Los Usuarios!</h1>
        <% if (request.getAttribute("errorMessage") != null) {%>
        <p style ="color:red;"><%= request.getAttribute("errorMessage")%></p>
        <% } %>
        <% if (request.getAttribute("successMessage") != null) {%>
        <p style ="color:green;"><%= request.getAttribute("successMessage")%></p>
        <% } %>
        <%-- Tablas con lista de Usuarios --%>
        <table border="1">
            <thead>
                <tr>
                    <th>Id</th> 
                    <th>Password</th> 
                    <th>Nombre</th> 
                    <th>Apellidos</th>
                    <th>Rol</th> 
                    <th>Email</th> 
                    <th>Telefono</th> 
                    <th>Estado</th> 
                    <th>Fecha de Registro</th> 
                    <th>Acciones</th> 
                </tr>
            </thead>
            <tbody>
                <% List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuario");%>
                <% if (usuarios != null && !usuarios.isEmpty()) {%>
                <% for (Usuario usuario : usuarios) {%>
                <tr>
                    <td><%= usuario.getId()%></td>
                    <td><%= usuario.getPassword()%></td> 
                    <td><%= usuario.getNombre()%></td> 
                    <td><%= usuario.getApellidos()%></td> 
                    <td><%= usuario.getRol()%></td> 
                    <td>
                        <a href="mailto:?cc<%= usuario.getEmail()%>&subject=Saludos &body= Buenas, Saludos">
                            <%= usuario.getEmail()%>
                        </a>    
                    </td> 
                    <td><%= usuario.getTelefono()%></td> 
                    <td><%= usuario.getEstado()%></td> 
                    <td><%= usuario.getFecha_registro()%></td> 
                    <td>
                        <a href="UsuarioControllers.jsp?action=buscar&id=<%= usuario.getId()%>" >Editar</a>
                        <a href="UsuarioControllers.jsp?action=eliminarfl&id=<%= usuario.getId()%>" onclick="return confirm('¿Seguro que desea eliminar este usuario?');">Eliminar</a>
                    </td> 
                </tr>
                <% } %>
                <% } else{ %>
                <tr>
                    <td colspan="10">No hay usuarios disponibles</td>
                </tr>
                <% } %>
            </tbody>
        </table>
            
            <br>
            <a href="<%= request.getContextPath() %>/Controllers/UsuarioControllers.jsp?action=mostrarCrearFormulario">Agregar Nuevo Usuario</a>
    </body>
</html>

<%-- 
    Document   : UsuarioControllers
    Created on : 5/11/2024, 4:29:52 p. m.
    Author     : Abraham Yendes
--%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.text.ParseException" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="Business.Exceptions.DuplicateUsuarioException"%>
<%@page import="java.io.IOException"%> <!-- IMPORTACIóN DE IOException -->
<%@page import="jakarta.servlet.ServletException"%> <!-- IMPORTACION DE ServletException -->
<%@page import="jakarta.servlet.http.HttpServletRequest"%> <!-- IMPORTACIoN DE HttpServletRequest -->
<%@page import="jakarta.servlet.http.HttpServletResponse"%> <!-- IMPORTACIoN DE HttpServletResponse -->
<%@page import="jakarta.servlet.http.HttpSession"%> <!-- IMPORTACI'N DE HttpSession -->
<%@page import="Business.Services.UsuarioService"%>
<%@page import="Domain.Model.Usuario"%>
<%@page import="Business.Exceptions.UsuarioNotFoundException"%>
<%@page import="Business.Exceptions.DuplicateUsuarioException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    UsuarioService usuarioService = new UsuarioService();
    String action = request.getParameter("action");
    if (action == null) {
        action = "list";
    }
    switch (action) {
        case "login":
            handleLogin(request, response, session);
            break;
        case "authenticate":
            handleAutenticar(request, response, session, usuarioService);
            break;
        case "mostrarCrearFormulario":
            mostrarCrearFormulario(request, response);
            break;
        case "crear":
            handleCrearUsuario(request, response, usuarioService);
            break;
        case "mostrarBuscarFormulario":
            mostrarBuscarFormulario(request, response, session, usuarioService);
            break;
        case "buscar":
            handleBuscar(request, response, session, usuarioService);
            break;
        case "actualizar":
            handleActualizarUsuario(request, response, session, usuarioService);
            break;
        case "eliminar":
            handleEliminarUsuario(request, response, session, usuarioService);
            break;
        case "eliminarfl":
            handleEliminarUsuarioFromList(request, response, session, usuarioService);
            break;
        case "listarTodo":
            handleListarTodosLosUsuarios(request, response, usuarioService);
            break;
        case "logout":
            handleLogout(request, response, session);
            break;
        default:
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            break;
    }
%>
<%!
// Metodo para mostrar el formulario de login
    private void handleLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        session.invalidate(); // Cerramos la sesión existente
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Usuarios/login.jsp");
    }
// Metodo para autenticar el usuario

    private void handleAutenticar(HttpServletRequest request, HttpServletResponse response, HttpSession session, UsuarioService usuarioService)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        try {
            Usuario loggedInUsuario = usuarioService.loginUsuario(email, password);
            session.setAttribute("loggedInUsuario", loggedInUsuario); // Guardamos el usuario en la sesión
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch (UsuarioNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Usuarios/login.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos. Intentelo nuevamente.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/login.jsp").forward(request, response);
        }
    }
// Mostrar el formulario para crear un usuario

    private void mostrarCrearFormulario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Usuarios/crear.jsp");
    }
// Metodo para crear un nuevo usuario (despues de enviar el formulario)

    private void handleCrearUsuario(HttpServletRequest request, HttpServletResponse response, UsuarioService usuarioService)
            throws ServletException, IOException {
        int id = 1;
        String password = request.getParameter("password");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String rol = request.getParameter("rol");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String estado = request.getParameter("estado");

        // Obtener la fecha actual
        java.sql.Date fecha_registro = new java.sql.Date(System.currentTimeMillis());

        try {
            usuarioService.crearUsuario(id, password, nombre, apellidos, rol, email, telefono, estado, fecha_registro);
            request.setAttribute("successMessage", "Usuario creado exitosamente.");
            handleListarTodosLosUsuarios(request, response, usuarioService);
        } catch (DuplicateUsuarioException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Usuarios/crear.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos. Intentelo nuevamente.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/crear.jsp").forward(request, response);
        }
    }
// Mostrar el formulario para editar un usuario

    private void mostrarBuscarFormulario(HttpServletRequest request, HttpServletResponse response, HttpSession session, UsuarioService usuarioService)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
    }
// Metodo para buscar un usuario

    private void handleBuscar(HttpServletRequest request, HttpServletResponse response, HttpSession session, UsuarioService usuarioService)
            throws ServletException, IOException {
        int buscarId = Integer.parseInt(request.getParameter("id"));
        try {
            Usuario usuario = usuarioService.buscarUsuarioPorId(buscarId);
            session.setAttribute("buscarUsuario", usuario); // Guardamos el usuario en la sesion
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (UsuarioNotFoundException e) {
            session.removeAttribute("buscarUsuario"); // Limpiamos la sesion si no se encuentra el usuario
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        }
    }
// Mostrar el formulario para editar un usuario

    private void mostrarEditarUsuarioForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, UsuarioService usuarioService)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Usuario usuario = usuarioService.buscarUsuarioPorId(id);
            session.setAttribute("usuarioAEditar", usuario); // Guardamos el usuario en sesion
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (UsuarioNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Usuario/listar_todos.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/listar_todos.jsp").forward(request, response);
        }
    }
// Metodo para actualizar los datos del usuario

    private void handleActualizarUsuario(HttpServletRequest request, HttpServletResponse response, HttpSession session, UsuarioService usuarioService)
            throws ServletException, IOException {
        Usuario buscarUsuario = (Usuario) session.getAttribute("buscarUsuario");
        if (buscarUsuario == null) {
            request.setAttribute("errorMessage", "Primero debe buscar un usuario para editar.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
            return;
        }
        int id = buscarUsuario.getId();// Usamos el id del usuario buscado
        String password = request.getParameter("password");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String rol = request.getParameter("rol");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String estado = request.getParameter("estado");
        LocalDate localDate = LocalDate.of(2024, 11, 22);
        Date fecha_registro = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    
        try {
            usuarioService.actualizarUsuario(id, password, nombre, apellidos, rol, email, telefono, estado, fecha_registro);
            request.setAttribute("successMessage", "Usuario actualizado exitosamente.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (UsuarioNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        }
    }

    private void handleEliminarUsuarioFromList(HttpServletRequest request, HttpServletResponse response, HttpSession session, UsuarioService usuarioService)
            throws ServletException, IOException {
        String idUsuario = request.getParameter("id");
        if (idUsuario == null || idUsuario.trim().isEmpty()) {
            request.setAttribute("errorMessage", "El codigo es requerido");
            request.getRequestDispatcher("/Views/Forms/Usuarios/listar_todo.jsp").forward(request, response);
            return ;
        }
        try {
            int id = Integer.parseInt(idUsuario);
            usuarioService.eliminarUsuario(id);
            session.removeAttribute("buscarUsuario");
            request.setAttribute("successMessage", "Usuario eliminado exitosamente.");
            handleListarTodosLosUsuarios(request, response, usuarioService);
        } catch (UsuarioNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            handleListarTodosLosUsuarios(request, response, usuarioService);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            handleListarTodosLosUsuarios(request, response, usuarioService);
        }
    }
// Metodo para eliminar un usuario

    private void handleEliminarUsuario(HttpServletRequest request, HttpServletResponse response, HttpSession session, UsuarioService usuarioService)
            throws ServletException, IOException {
        Usuario buscarUsuario = (Usuario) session.getAttribute("buscarUsuario");
        if (buscarUsuario == null) {
            request.setAttribute("errorMessage", "Primero debe buscar un usuario para eliminar.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
            return;
        }
        int id = buscarUsuario.getId(); // Usamos el id del usuario buscado
        try {
            usuarioService.eliminarUsuario(id);
            session.removeAttribute("buscarUsuario");
            request.setAttribute("successMessage", "Usuario eliminado exitosamente.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (UsuarioNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        }
    }
// Metodo para listar todos los usuarios

    private void handleListarTodosLosUsuarios(HttpServletRequest request, HttpServletResponse response, UsuarioService usuarioService)
            throws ServletException, IOException {
        try {
            List<Usuario> usuarios = usuarioService.obtenerTodosLosUsuarios();
            request.setAttribute("usuarios", usuarios);
            request.getRequestDispatcher("/Views/Forms/Usuarios/listar_todos.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos al listar usuarios.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/listar_todos.jsp").forward(request, response);
        }
    }
// Metodo para cerrar sesion

    private void handleLogout(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        session.invalidate(); // Invalida la sesion actual
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Usuarios/login.jsp");
    }
%>
<%-- 
    Document   : agregar
    Created on : 5/11/2024, 4:30:40 p. m.
    Author     : Dina Perez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="../../js/color-modes.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrar Usuario</title>   
        <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/checkout/">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
        <link href="../../dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="../../Css/style-chechout.css" rel="style-chechout">
        <link href="../../Css/checkout.css" rel="stylesheet">
    </head>
    <body class="bg-body-tertiary">
    <svg xmlns="http://www.w3.org/2000/svg" class="d-none">
      <symbol id="check2" viewBox="0 0 16 16">
        <path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z"/>
      </symbol>
      <symbol id="circle-half" viewBox="0 0 16 16">
        <path d="M8 15A7 7 0 1 0 8 1v14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z"/>
      </symbol>
      <symbol id="moon-stars-fill" viewBox="0 0 16 16">
        <path d="M6 .278a.768.768 0 0 1 .08.858 7.208 7.208 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277.527 0 1.04-.055 1.533-.16a.787.787 0 0 1 .81.316.733.733 0 0 1-.031.893A8.349 8.349 0 0 1 8.344 16C3.734 16 0 12.286 0 7.71 0 4.266 2.114 1.312 5.124.06A.752.752 0 0 1 6 .278z"/>
        <path d="M10.794 3.148a.217.217 0 0 1 .412 0l.387 1.162c.173.518.579.924 1.097 1.097l1.162.387a.217.217 0 0 1 0 .412l-1.162.387a1.734 1.734 0 0 0-1.097 1.097l-.387 1.162a.217.217 0 0 1-.412 0l-.387-1.162A1.734 1.734 0 0 0 9.31 6.593l-1.162-.387a.217.217 0 0 1 0-.412l1.162-.387a1.734 1.734 0 0 0 1.097-1.097l.387-1.162zM13.863.099a.145.145 0 0 1 .274 0l.258.774c.115.346.386.617.732.732l.774.258a.145.145 0 0 1 0 .274l-.774.258a1.156 1.156 0 0 0-.732.732l-.258.774a.145.145 0 0 1-.274 0l-.258-.774a1.156 1.156 0 0 0-.732-.732l-.774-.258a.145.145 0 0 1 0-.274l.774-.258c.346-.115.617-.386.732-.732L13.863.1z"/>
      </symbol>
      <symbol id="sun-fill" viewBox="0 0 16 16">
        <path d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"/>
      </symbol>
    </svg>

        <% if (request.getAttribute("errorMessage") != null) {%>
        <p style="color:red;"><%= request.getAttribute("errorMessage")%></p>
        <%}%>

        <% if (request.getAttribute("successMessage") != null) {%>
        <p style = "color:green;"><%= request.getAttribute("succesMessage")%></p>
        <% }%>
        <%-- Formulario --%>
        <div class="container">
            <main>
                <div class="py-5 text-center">
                    <img class="d-block mx-auto mb-4" src="../../Img/+usuario.png" alt="" width="72" height="57">
                    <h2>Registrar Usuario</h2>
                    <p class="lead">Completa el Formulario de Registro.</p>
                </div>
                <div class="row g-5">
                    <div class="col-md-7 col-lg-8">
                        <form class="needs-validation" action="<%= request.getContextPath() %>/Controllers/UsuarioControllers.jsp?action=crear" method="post">

                            <div class="row g-3">
                                <div class="col-sm-6">
                                    <label for="firstName" class="form-label">Nombre</label>
                                    <input type="text" class="form-control" id="firstName" name= "nombre" placeholder="" value="" required>
                                    <div class="invalid-feedback">
                                        *Campo requerido.
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <label for="lastName" class="form-label">Apellidos</label>
                                    <input type="text" class="form-control" id="lastName" name="apellidos"placeholder="" value="" required>
                                    <div class="invalid-feedback">
                                        *Campo requerido.
                                    </div>
                                </div>

                                <div class="col-12">
                                    <label for="username" class="form-label">email</label>
                                    <div class="input-group has-validation">
                                        <span class="input-group-text">@</span>
                                        <input type="email" class="form-control" id="username" name="email" placeholder="you@example.com" required>
                                        <div class="invalid-feedback">
                                            Tu Email es requerido.
                                        </div>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <label for="email" class="form-label">password <span class="text-body-secondary">(Para Validar Usuario)</span></label>
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                                    <div class="invalid-feedback">
                                        Por Favor ingresa password.
                                    </div>
                                </div>

                                <div class="col-md-5">
                                    <label for="country" class="form-label">rol</label>
                                    <select class="form-select" id="rol" name="rol" required>
                                        <option value="">Seleccione...</option>
                                        <option>Administrador</option>
                                        <option>Usuario</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Por Favor Ingresar un rol Valido.
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <label for="state" class="form-label">Estado</label>
                                    <select class="form-select" id="state" name="estado" required>
                                        <option value="">Seleccione...</option>
                                        <option>Activo</option>
                                        <option>Inactivo</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Por Favor Ingresar Estado Valido.
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <label for="zip" class="form-label">Telefono</label>
                                    <input type="text" class="form-control" id="telefono" name="telefono" placeholder="310-567-8989">
                                    <div class="invalid-feedback">
                                    </div>
                                </div>

                                <hr class="my-4">

                                <button class="w-100 btn btn-primary btn-lg" type="submit" value="Agregar Usuario">Registrar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
        <footer class="my-5 pt-5 text-body-secondary text-center text-small">
            <p class="mb-1">&copy; 2024–2025 DSW</p>
            <ul class="list-inline">
              <li class="list-inline-item"><a href="<%= request.getContextPath()%>/index.jsp">Menú Principal</a></li>
            </ul>
        </footer>
        <script src="../../dist/js/bootstrap.bundle.min.js"></script>
        <script src="../../js/checkout.js"></script>
    </body>
</html>

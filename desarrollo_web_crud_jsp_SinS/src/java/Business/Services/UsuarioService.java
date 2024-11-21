/*
 * Clase encargada de servicios servicios de usuario
 * 
 */
package Business.Services;

import Domain.Model.Usuario;
import java.sql.SQLException;
import Infrastructure.Persistence.UsuarioCRUD;
import Business.Exceptions.DuplicateUsuarioException;
import Business.Exceptions.UsuarioNotFoundException;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Abraham Yendes
 */
public class UsuarioService {
    
    private UsuarioCRUD usuarioCrud;
    
    public UsuarioService(){
        this.usuarioCrud = new UsuarioCRUD();
    }
    
    // Metodo para crear un nuevo usuario
    
    public void crearUsuario(int id, String password, String nombre, String apellidos, String rol, String email, String telefono, String estado, Date fecha_registro) throws DuplicateUsuarioException, SQLException{
        Usuario usuario = new Usuario(id, password, nombre, apellidos, rol, email, telefono, estado, fecha_registro);
        usuarioCrud.crearUsuario(usuario);
    }
    
    // Metodo para buscar usuario por id
    
    public Usuario buscarUsuarioPorId(int id)throws UsuarioNotFoundException, SQLException{
        return usuarioCrud.buscarUsuarioPorId(id);
    }
    
    // Metodo para editar usuario
    
    public void actualizarUsuario(int id, String password, String nombre, String apellidos, String rol, String email, String telefono, String estado, Date fecha_registro) throws UsuarioNotFoundException, SQLException{
        Usuario usuario = new Usuario(id, password, nombre, apellidos, rol, email, telefono, estado, fecha_registro);
        usuarioCrud.actualizarUsuario(usuario);
    }
    
    // Metodo para eliminar usuario utilizando el id
    
    public void eliminarUsuario(int id) throws UsuarioNotFoundException, SQLException{
        usuarioCrud.eliminarUsuario(id);
    }
    
    // Metodo para validar usuario "inicio de sesion"
    
    public Usuario loginUsuario(String email, String password)throws UsuarioNotFoundException, SQLException{
        Usuario usuario = usuarioCrud.buscarUsuarioPorEmail(email);
        
        if(usuario != null && usuario.getPassword().equals(password)){
           return usuario; 
        }else {
            throw new UsuarioNotFoundException("Combinacion de email y password invalidos ó no existen");
        }
    }
    
    // Metodo para listar todos los usuarios
    
    public List<Usuario> buscarUsuarios(String searchTerm){
        return usuarioCrud.buscarUsuarios(searchTerm);
    }
    
    // Metodo para listar todos los usuarios
    
    public List<Usuario> obtenerTodosLosUsuarios() throws SQLException{
        return usuarioCrud.listarUsuarios();
    }
    
}

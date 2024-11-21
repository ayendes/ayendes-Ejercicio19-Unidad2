/*
 *Clase de infraestructura donde el usuario puede realizar CRUD 
 * En la base de datos
 */
package Infrastructure.Persistence;

import Business.Exceptions.DuplicateUsuarioException;
import Domain.Model.Usuario;
import Business.Exceptions.UsuarioNotFoundException;
import Infrastructure.Database.ConnectionDbMySql;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Abraham Yendes
 */
public class UsuarioCRUD {
    
    // Metodo para agregar Usuario
    public void crearUsuario(Usuario usuario) throws SQLException, DuplicateUsuarioException {
      String query = "INSERT INTO Usuarios(password, nombre, apellidos, rol, email, telefono, estado, fecha_registro) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
      try(Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)){
       // Establecer la fecha de registro
          java.sql.Date fecha_registroSql = new java.sql.Date(usuario.getFecha_registro().getTime());
          stmt.setString(1, usuario.getPassword());
          stmt.setString(2, usuario.getNombre());
          stmt.setString(3, usuario.getApellidos());
          stmt.setString(4, usuario.getRol());
          stmt.setString(5, usuario.getEmail());
          stmt.setString(6, usuario.getTelefono());
          stmt.setString(7, usuario.getEstado());
          stmt.setDate(8, fecha_registroSql);
          stmt.executeUpdate();
          
      }catch (SQLException e){
         if(e.getErrorCode()==1062){
             throw new DuplicateUsuarioException("Usuario con Codigo: "+ usuario.getId() +" ó Email: "+usuario.getEmail()+" ya existe.");
         } else{
             throw e;
         }
      }
    }
    
    // Metodo para consultar usuario por ID
    public Usuario buscarUsuarioPorId(int id) throws SQLException, UsuarioNotFoundException{
       String query = "SELECT * FROM Usuarios WHERE code=?";
       Usuario usuario = null;
       try(Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)){
           stmt.setInt(1, id);
           ResultSet rs = stmt.executeQuery();
           if (rs.next()){
              usuario = new Usuario (rs.getInt("id"), rs.getString("password"), rs.getString("nombre"), rs.getString("apellidos"), rs.getString("rol"), rs.getString("email"), rs.getString("telefono"), rs.getString("estado"), rs.getDate("fecha_registro"));
           }else{
               throw new UsuarioNotFoundException("Usuario con codigo: "+ id +" no existe.");
           }
       }catch (SQLException e){
           throw e;
       }return usuario;
    }
    
    // Metodo para consultar usuario por email y password
    
     public Usuario buscarUsuarioPorEmailYPassword(String email, String password) throws SQLException, UsuarioNotFoundException{
       Usuario usuario = null;
       String query = "SELECT * FROM Usuarios WHERE email=? AND password =?";
       
       try{Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query);   
           stmt.setString(1, email);
           stmt.setString(2, password);
           ResultSet rs = stmt.executeQuery();
           if (rs.next()){
              usuario = new Usuario (
                      rs.getInt("id"), rs.getString("password"), rs.getString("nombre"), rs.getString("apellidos"), rs.getString("rol"), rs.getString("email"), rs.getString("telefono"), rs.getString("estado"), rs.getDate("fecha_registro"));
           }else{
               var message = "Convinacion de Email y Password es incorrecto ó no existe.";
               throw new UsuarioNotFoundException(message);
           }
       }catch (SQLException e){
           e.printStackTrace();
       }return usuario;
    }
     
     // Metodo para consultar usuario por email
     
    public Usuario buscarUsuarioPorEmail(String email) throws SQLException, UsuarioNotFoundException{
       Usuario usuario = null;
       String query = "SELECT * FROM Usuarios WHERE email=?";
       
       try(Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)){
           stmt.setString(1, email);
           ResultSet rs = stmt.executeQuery();
           if (rs.next()){
              usuario = new Usuario (rs.getInt("id"), rs.getString("password"), rs.getString("nombre"), rs.getString("apellidos"), rs.getString("rol"), rs.getString("email"), rs.getString("telefono"), rs.getString("estado"), rs.getDate("fecha_registro"));
           }else{
               throw new UsuarioNotFoundException("Usuario con email: "+ email +" no existe");
           }
       }return usuario;
    }
    
    // Metodo para actualizar usuario
    public void actualizarUsuario(Usuario usuario) throws SQLException, UsuarioNotFoundException{
       
       String query = "UPDATE Usuarios SET password=?, nombre=?, apellido=?, rol=?, email=?, telefono=?, estado=? WHERE id=?";
       
       try(Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)){
           stmt.setInt(1, usuario.getId());
           stmt.setString(1, usuario.getPassword());
           stmt.setString(1, usuario.getNombre());
           stmt.setString(1, usuario.getApellidos());
           stmt.setString(1, usuario.getRol());
           stmt.setString(1, usuario.getEmail());
           stmt.setString(1, usuario.getTelefono());
           stmt.setString(1, usuario.getEstado());
           int rowsAffected = stmt.executeUpdate();
           if (rowsAffected == 0){
               throw new UsuarioNotFoundException("Usuario con id: "+ usuario.getId() +" no existe");
              }    
           }catch (SQLException e){
              throw e;   
       }
    }
    
    // Metodo para eliminar usuario
    public void eliminarUsuario(int id) throws SQLException, UsuarioNotFoundException{
       
       String query = "DELETE FROM Usuarios WHERE id=?";
       
       try(Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)){
           stmt.setInt(1, id);
           int rowsAffected = stmt.executeUpdate();
           if (rowsAffected == 0){
               throw new UsuarioNotFoundException("Usuario con id: "+ id +" no existe");
              }    
           }catch (SQLException e){
              throw e;   
       }
    }
    
    // Metodo para buscar usuarios por nombre o email
    public List<Usuario> buscarUsuarios(String searchTerm) {
       List<Usuario> usuarioList = new ArrayList<>();
       String query = "SELECT * FROM Usuarios WHERE name LIKE ? OR email LIKE ?";
       
       try{Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query);   
           stmt.setString(1, "%" + searchTerm + "%");
           stmt.setString(2, "%" + searchTerm + "%");
           ResultSet rs = stmt.executeQuery();
           while (rs.next()){
              usuarioList.add( new Usuario (rs.getInt("id"), rs.getString("password"), rs.getString("nombre"), rs.getString("apellidos"), rs.getString("rol"), rs.getString("email"), rs.getString("telefono"), rs.getString("estado"), rs.getDate("fecha_registro")));
           }
       }catch (SQLException e){
           e.printStackTrace();
       }return usuarioList;
    }
    
    // Metodo para listar todos usuarios
    public List<Usuario> listarUsuarios() {
       List<Usuario> usuarioList = new ArrayList<>();
       String query = "SELECT * FROM Usuarios";
       
       try{Connection con = ConnectionDbMySql.getConnection(); Statement stmt = con.createStatement();   
           
           ResultSet rs = stmt.executeQuery(query);
           while (rs.next()){
              usuarioList.add( new Usuario (rs.getInt("id"), rs.getString("password"), rs.getString("nombre"), rs.getString("apellidos"), rs.getString("rol"), rs.getString("email"), rs.getString("telefono"), rs.getString("estado"), rs.getDate("fecha_registro")));
           }
       }catch (SQLException e){
           e.printStackTrace();
       }return usuarioList;
    }
}

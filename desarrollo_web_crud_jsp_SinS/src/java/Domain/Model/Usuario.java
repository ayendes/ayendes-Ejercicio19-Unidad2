/*
 * Class con la informacion que debe contener cada usuario
 * 
 */
package Domain.Model;

import java.util.Date;

/**
 *
 * @author Abraham Yendes
 */
public class Usuario {
    private int id; 
   private String password; 
   private String nombre; 
   private String apellidos; 
   private String rol; 
   private String email; 
   private String telefono; 
   private String estado; 
   private Date fecha_registro; 
   
   // Constructores

    public Usuario() {
    }

    public Usuario(int id, String password, String nombre, String apellidos, String rol, String email, String telefono, String estado, Date fecha_registro) {
        this.id = id;
        this.password = password;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.rol = rol;
        this.email = email;
        this.telefono = telefono;
        this.estado = estado;
        this.fecha_registro = new Date();
    }
    
   // Metodos getter y setter

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Date getFecha_registro() {
        return fecha_registro;
    }

    public void setFecha_registro(Date fecha_registro) {
        this.fecha_registro = fecha_registro;
    }
    
}

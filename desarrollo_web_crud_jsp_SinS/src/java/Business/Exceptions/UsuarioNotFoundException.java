/*
 * Clase para exections donde el usuario
 */
package Business.Exceptions;

/**
 *
 * @author Abraham Yendes
 */
public class UsuarioNotFoundException extends Exception{
  public UsuarioNotFoundException(String message){
      super(message);
  }  
    
}

/*
 * Clase de exception para el usuario duplicado
 * 
 */
package Business.Exceptions;

/**
 *
 * @author Abraham Yendes
 */
public class DuplicateUsuarioException extends Exception{
    public DuplicateUsuarioException(String message){
        super(message);
    }
    
}

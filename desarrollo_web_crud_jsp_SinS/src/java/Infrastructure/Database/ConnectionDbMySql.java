/*
 * Class encargada de tener la informacion para conectar con la base de Datos del proyecto
 * 
 */
package Infrastructure.Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


/**
 *
 * @author Abraham Yendes
 */
public class ConnectionDbMySql {
    
    private static final String URL = "jdbc:mysql://localhost:3306/ejercicio19";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    
    public static Connection getConnection( )throws SQLException{
        Connection connection = null;
        try{
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        }catch (ClassNotFoundException e){
            e.printStackTrace();
            throw new SQLException("Error: Driver MySQL no encontrado.");
        }catch (SQLException e){
          e.printStackTrace();
          var message = "Error: No se puede establecer la conexion con la base de datos.";
          throw new SQLException(message);
        }
        return connection;
    }
}

package storage;

import com.mysql.jdbc.JDBC4Connection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UsersDAO {

    private static Properties info;
    private static String dbName = "leilaoDatabase";
    private static String tableName = "users";
    private static String host = "localhost";
    private static int port = 3306;
    
    private static UsersDAO usersDAOInstance;
    
    private UsersDAO() {
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            Statement statement = connection.createStatement();
            String st = "CREATE TABLE IF NOT EXISTS " + tableName + "(userName VARCHAR(10) PRIMARY KEY, password VARCHAR(10), isAdmin VARCHAR(1))";
            statement.execute(st);
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static UsersDAO getInstance(){
        if(usersDAOInstance == null){
            info = new Properties();
            info.put("user", "root");
            info.put("password", "onurb");
            usersDAOInstance = new UsersDAO();
        }
        return usersDAOInstance;
    }       
    
    public String createUser(String userName, String password, String isAdmin){ // isAdmin == 0 || isAdmin == 1
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            Statement statement = connection.createStatement();
            String st = "INSERT INTO " + tableName + " VALUES('" + userName + "','" + password + "','" + isAdmin + "')";
            statement.execute(st);
            return null;
        } catch (SQLIntegrityConstraintViolationException exception){
            return "Participante já cadastrado!";
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
            return "Erro inesperado. Tente novamente mais tarde.";
        }
    }
    
    public String getUserWithName(String username){
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            Statement statement = connection.createStatement();
            String query = "SELECT password " + " FROM " + tableName + " WHERE users.username = '" + username + "'";
            ResultSet resultSet = statement.executeQuery(query);
            if(resultSet.first()){
                return resultSet.getObject("password", String.class);
            } else {
                return null;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public boolean isUserAdmin(String username) {
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            Statement statement = connection.createStatement();
            String query = "SELECT isAdmin " + " FROM " + tableName + " WHERE users.username = '" + username + "'";
            ResultSet resultSet = statement.executeQuery(query);
            if(resultSet.first()){
                String isAdmin = resultSet.getObject("isAdmin", String.class);
                return isAdmin.equals("1");
            } else {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}

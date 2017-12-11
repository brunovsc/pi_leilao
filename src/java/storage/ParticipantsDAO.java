package storage;

import com.mysql.jdbc.JDBC4Connection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ParticipantsDAO {
    
    private static Properties info;
    private static String dbName = "leilaoDatabase";
    private static String tableName = "participants";
    private static String host = "localhost";
    private static int port = 3306;
    
    private static ParticipantsDAO participantsDAOInstance;
    
    private ParticipantsDAO() {
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            Statement statement = connection.createStatement();
            String st = "CREATE TABLE IF NOT EXISTS " + tableName + "("
                    + "participantId INT NOT NULL AUTO_INCREMENT, "
                    + "name VARCHAR(15), "
                    + "userId VARCHAR(10), "
                    + "PRIMARY KEY (participantId), "
                    + "FOREIGN KEY (userId) REFERENCES users(userName)"
                    + ")";
            statement.execute(st);
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static ParticipantsDAO getInstance(){
        if(participantsDAOInstance == null){
            info = new Properties();
            info.put("user", "root");
            info.put("password", "onurb");
            participantsDAOInstance = new ParticipantsDAO();
        }
        return participantsDAOInstance;
    } 
    
    public String createParticipant(String name, String userId){
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            Statement statement = connection.createStatement();
            String st = "INSERT INTO " + tableName + " (name, userId) VALUES('" + name + "','" + userId + "')";
            statement.execute(st);
            
            Statement getId = connection.createStatement();
            String query = "SELECT participantId " + " FROM " + tableName + " WHERE participants.userId = '" + userId + "'";
            ResultSet resultSet = getId.executeQuery(query);
            System.out.println(resultSet.getObject("userId", String.class));
            if(resultSet.first()){
                return resultSet.getObject("userId", String.class);
            } else {
                return null;
            }
        } catch (SQLIntegrityConstraintViolationException exception){
            return "Participante já cadastrado!";
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
            return "Erro inesperado. Tente novamente mais tarde.";
        }
    }
}

package storage;

import com.mysql.jdbc.JDBC4Connection;
import domain.Auction;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AuctionsDAO {
    
    private static Properties info;
    private static String dbName = "leilaoDatabase";
    private static String tableName = "auctions";
    private static String host = "localhost";
    private static int port = 3306;
    
    private static AuctionsDAO auctionsDAOInstance;
    
    private AuctionsDAO() {
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            Statement statement = connection.createStatement();
            String st = "CREATE TABLE IF NOT EXISTS " + tableName + "("
                    + "auctionId INT NOT NULL AUTO_INCREMENT, "
                    + "productDescription VARCHAR(50), "
                    + "minimumBid INT, "
                    + "currentBid INT, "
                    + "opened VARCHAR(1), "
                    + "PRIMARY KEY (auctionId)"
                    + ")";
            statement.execute(st);
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static AuctionsDAO getInstance(){
        if(auctionsDAOInstance == null){
            info = new Properties();
            info.put("user", "root");
            info.put("password", "onurb");
            auctionsDAOInstance = new AuctionsDAO();
        }
        return auctionsDAOInstance;
    } 
    
    public String createAuction(String productDescription, int minimumBid, int currentBid, boolean isOpened){
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            Statement statement = connection.createStatement();
            String openedString = isOpened ? "1" : "0";
            String st = "INSERT INTO " + tableName + " (productDescription, minimumBid, currentBid, opened) VALUES('" + productDescription + "'," + minimumBid + "," + currentBid + ",'" + openedString + "')";
            statement.execute(st);
            return "";
        } catch (SQLException ex) {
            Logger.getLogger(AuctionsDAO.class.getName()).log(Level.SEVERE, null, ex);
            return "Erro inesperado. Tente novamente mais tarde.";
        }
    }
    
    public ArrayList<Auction> getAuctions(){
        ArrayList<Auction> auctions = new ArrayList<>();
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            Statement st = connection.createStatement();
            String query = "SELECT * " + " FROM " + tableName;
            ResultSet resultSet = st.executeQuery(query);
            while(resultSet.next()){
                int auctionId = resultSet.getInt("auctionId");
                String productDescription = resultSet.getString("productDescription");
                int minimumBid = resultSet.getInt("minimumBid");
                int currentBid = resultSet.getInt("currentBid");
                boolean opened = resultSet.getBoolean("opened");
                auctions.add(new Auction(auctionId, productDescription, minimumBid, currentBid, opened));
            }
            return auctions;
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
            return auctions;
        }
    }
}

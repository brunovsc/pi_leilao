package storage;

import com.mysql.jdbc.JDBC4Connection;
import domain.Auction;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
    
    public Auction createAuction(String productDescription, int minimumBid, int currentBid, boolean isOpened){
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            String openedString = isOpened ? "1" : "0";
            String st = "INSERT INTO " + tableName + " (productDescription, minimumBid, currentBid, opened) VALUES('" + productDescription + "'," + minimumBid + "," + currentBid + ",'" + openedString + "')";
            
            PreparedStatement statement = connection.prepareStatement(st,Statement.RETURN_GENERATED_KEYS);
            int affectedRows = statement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating auction failed, no rows affected.");
            }
            Auction auction;
            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    auction = new Auction(generatedKeys.getInt(1), productDescription, minimumBid, currentBid, isOpened);
                }
                else {
                    auction = null;
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }
            return auction;
        } catch (SQLException ex) {
            Logger.getLogger(AuctionsDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
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
    
    public boolean updateAuctionIdWithStatus(int auctionId, boolean status){
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            Statement st = connection.createStatement();
            String query = "UPDATE " + tableName + " SET opened = " + (status ? "1" : "0") + " WHERE auctionId = " + auctionId;
            int rowsAffected = st.executeUpdate(query);
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public Auction getAuctionWithId(int auctionId){
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            Statement st = connection.createStatement();
            String query = "SELECT * " + " FROM " + tableName + " WHERE auctionId = " + auctionId;
            ResultSet resultSet = st.executeQuery(query);
            while(resultSet.next()){
                int newAuctionId = resultSet.getInt("auctionId");
                String productDescription = resultSet.getString("productDescription");
                int minimumBid = resultSet.getInt("minimumBid");
                int currentBid = resultSet.getInt("currentBid");
                boolean opened = resultSet.getBoolean("opened");
                return new Auction(newAuctionId, productDescription, minimumBid, currentBid, opened);
            }
            return null;
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public boolean updateBidValueOnAuctionWithId(int auctionId, int bidValue){
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            Statement st = connection.createStatement();
            String query = "UPDATE " + tableName + " SET currentBid = " + bidValue + " WHERE auctionId = " + auctionId;
            int rowsAffected = st.executeUpdate(query);
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}

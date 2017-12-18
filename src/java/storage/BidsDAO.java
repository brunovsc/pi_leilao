package storage;

import com.mysql.jdbc.JDBC4Connection;
import domain.Bid;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BidsDAO {
    
    private static Properties info;
    private static final String dbName = "leilaoDatabase";
    private static final String tableName = "bids";
    private static final String host = "localhost";
    private static final int port = 3306;
    
    private static BidsDAO bidsDAOInstance;
    
    private BidsDAO() {
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            Statement statement = connection.createStatement();
            String st = "CREATE TABLE IF NOT EXISTS " + tableName + "("
                    + "bidId INT NOT NULL AUTO_INCREMENT, "
                    + "auctionId INT, "
                    + "username VARCHAR(50), "
                    + "bidValue INT, "
                    + "PRIMARY KEY (bidId),"
                    + "FOREIGN KEY (auctionId) REFERENCES auctions(auctionId)"
                    + ")";
            statement.execute(st);
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static BidsDAO getInstance(){
        if(bidsDAOInstance == null){
            info = new Properties();
            info.put("user", "root");
            info.put("password", "onurb");
            bidsDAOInstance = new BidsDAO();
        }
        return bidsDAOInstance;
    }       
    
    public Bid createBidForAuctionWithBidValueAndUsername(int auctionId, int bidValue, String username){
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            String st = "INSERT INTO " + tableName + " (auctionId, username, bidValue) VALUES(" + auctionId + ",'" + username + "'," + bidValue + ")";
            
            PreparedStatement statement = connection.prepareStatement(st,Statement.RETURN_GENERATED_KEYS);
            int affectedRows = statement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating auction failed, no rows affected.");
            }
            Bid bid;
            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    bid = new Bid(generatedKeys.getInt(1), auctionId, username, bidValue);
                }
                else {
                    bid = null;
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }
            return bid;
        } catch (SQLException ex) {
            Logger.getLogger(AuctionsDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
      
    
    public ArrayList<Bid> getBidsForAuctionId(int auctionId){
        ArrayList<Bid> bids = new ArrayList<>();
        try (Connection connection = new JDBC4Connection(host, port, info, dbName, null)) {
            Statement st = connection.createStatement();
            String query = "SELECT * " + " FROM " + tableName + " WHERE auctionId = " + auctionId;
            ResultSet resultSet = st.executeQuery(query);
            while(resultSet.next()){
                int bidId = resultSet.getInt("bidId");
                String username = resultSet.getString("username");
                int bidValue = resultSet.getInt("bidValue");
                bids.add(new Bid(bidId, auctionId, username, bidValue));
            }
            return bids;
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
            return bids;
        }
    }
}

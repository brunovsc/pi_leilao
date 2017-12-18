package storage;

public class ManagerDAO {
    
    private static UsersDAO users;
    private static ParticipantsDAO participants;
    private static AuctionsDAO auctions;
    private static BidsDAO bids;
    
    private static ManagerDAO managerDAO;
    
    private ManagerDAO(){
        users = UsersDAO.getInstance();
        participants = ParticipantsDAO.getInstance();
        auctions = AuctionsDAO.getInstance();
        bids = BidsDAO.getInstance();
    }
    
    public static ManagerDAO getInstance(){
        if(managerDAO == null){
            managerDAO = new ManagerDAO();
        }
        return managerDAO;
    }
    
}

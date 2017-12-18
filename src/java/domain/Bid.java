
package domain;

public class Bid {
    
    private int bidId;
    private int bidValue;
    private int auctionId;
    private String username;

    public Bid(int bidId, int auctionId, String username, int bidValue) {
        this.bidId = bidId;
        this.auctionId = auctionId;
        this.bidValue = bidValue;
        this.username = username;
    }

    public int getBidValue() {
        return bidValue;
    }

    public int getBidId() {
        return bidId;
    }

    public void setBidValue(int bidValue) {
        this.bidValue = bidValue;
    }

    public int getAuctionId() {
        return auctionId;
    }

    public void setAuctionId(int auctionId) {
        this.auctionId = auctionId;
    }    

    public String getUsername() {
        return username;
    }
    
    
}

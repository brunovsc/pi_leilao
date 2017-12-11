
package domain;

public class Bid {
    
    private String id;
    private int bidValue;
    private int auctionId;

    public Bid(int auctionId, String id, int bidValue) {
        this.id = id;
        this.auctionId = auctionId;
        this.bidValue = bidValue;
    }

    public int getBidValue() {
        return bidValue;
    }

    public String getId() {
        return id;
    }

    public void setBidValue(int bidValue) {
        this.bidValue = bidValue;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getAuctionId() {
        return auctionId;
    }

    public void setAuctionId(int auctionId) {
        this.auctionId = auctionId;
    }    
}

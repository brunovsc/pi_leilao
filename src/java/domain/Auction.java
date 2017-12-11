package domain;

import java.util.ArrayList;

public class Auction {
    
    private int auctionId;
    private String productDescription;
    private int minBid;
    private ArrayList<Bid> bids;
    private boolean isOpened;
    private int bidValue;

    public Auction(){
        bids = new ArrayList<Bid>();
    }    
    
    public Auction(int id, String description, int minimumBid, int currentBid, boolean opened){
        bids = new ArrayList<Bid>();
        auctionId = id;
        productDescription = description;
        minBid = minimumBid;
        bidValue = currentBid;
        isOpened = opened;
    }
    
    public String getProductDescription() {
        return productDescription;
    }

    public float getMinBid() {
        return minBid;
    }

    public ArrayList<Bid> getBids() {
        return bids;
    }
    
    public void addBid(String bidId, int bidValue){
        bids.add(new Bid(this.auctionId, bidId, bidValue));
    }
    
    public void start(){
        isOpened = true;
    }
    
    public void close(){
        isOpened = false;
    }

    public int getAuctionId() {
        return auctionId;
    }

    public int getBidValue() {
        return bidValue;
    }
    
    public boolean isOpened() {
        return isOpened;
    }
    
}

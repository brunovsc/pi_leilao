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

    public int getMinBid() {
        return minBid;
    }

    public ArrayList<Bid> getBids() {
        return bids;
    }
    
    public void addBid(Bid bid){
        this.bidValue = bid.getBidValue();
        this.bids.add(bid);
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
    
    public int nextBidValue() {
        if(bidValue == 0){
            return minBid == 0 ? 10 : minBid;
        } else {
            return bidValue + 10;
        }
    }
    
    public boolean isOpened() {
        return isOpened;
    }

    public void setIsOpened(boolean isOpened) {
        this.isOpened = isOpened;
    }

    public void setBids(ArrayList<Bid> bids) {
        this.bids = bids;
    }
    
}

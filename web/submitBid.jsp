<%-- 
    Document   : submitBid
    Created on : 11/12/2017, 18:49:14
    Author     : Bruno
--%>

<%@page import="storage.BidsDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Bid"%>
<%@page import="domain.Auction"%>
<%@page import="storage.AuctionsDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dar lance</title>
    </head>
    <body>
        <%
        Auction auction = AuctionsDAO.getInstance().getAuctionWithId(Integer.parseInt(request.getParameter("auctionId")));
        if(!auction.isOpened()){
            %>
            <h1>O leilão para esse item não está aberto.</h1>
            <meta http-equiv="Refresh" content="3;url=participant.jsp">
            <%
        }
        int currentBid = auction.getBidValue();
        int newBid = currentBid + 10;
        String username = (String)request.getSession().getAttribute("username");
        boolean success = AuctionsDAO.getInstance().updateBidValueOnAuctionWithId(auction.getAuctionId(), newBid);
        Bid bid = BidsDAO.getInstance().createBidForAuctionWithBidValueAndUsername(auction.getAuctionId(), newBid, username);
        auction.getBids().add(bid);
        if(success){
            ArrayList<Auction> auctions = (ArrayList<Auction>)getServletContext().getAttribute("auctions");
            for(Auction a: auctions){
                if(a.getAuctionId() == auction.getAuctionId()){
                    a.addBid(bid);
                }
            }
            getServletContext().setAttribute("auctions", auctions);
            auctions = (ArrayList<Auction>)session.getAttribute("auctions");
            for(Auction a: auctions){
                if(a.getAuctionId() == auction.getAuctionId()){
                    a.addBid(bid);
                }
            }
            pageContext.setAttribute("bidValue", newBid);
            %>
            <h1>Lance de ${bidValue} dado com sucesso.</h1>
            <meta http-equiv="Refresh" content="3;url=participant.jsp">
            <%
        } else {
            %>            
            <h1>Falha ao registrar lance.</h1>
            <meta http-equiv="Refresh" content="3;url=participant.jsp">
            <%
        }
        %>
    </body>
</html>

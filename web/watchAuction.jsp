<%-- 
    Document   : watchAuction
    Created on : 11/12/2017, 18:59:49
    Author     : Bruno
--%>

<%@page import="storage.UsersDAO"%>
<%@page import="storage.AuctionsDAO"%>
<%@page import="domain.Auction"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Acompanhar Leilão</title>
    </head>
    <body>
        <%
        ArrayList<Auction> auctions = (ArrayList<Auction>)session.getAttribute("auctions");
        if(auctions == null){
            auctions = new ArrayList<Auction>();
        }
        Auction a = AuctionsDAO.getInstance().getAuctionWithId(Integer.parseInt(request.getParameter("auctionId")));
        boolean isWatching = false;
        for(Auction auc : auctions){
            if(auc.getAuctionId() == a.getAuctionId()){
                isWatching = true;
                break;
            }
        }
        if(!isWatching){
            auctions.add(a);   
            session.setAttribute("auctions", auctions);  
            %>
            <h1>Leilão adicionado à lista de leilões consultados.</h1>
            <meta http-equiv="Refresh" content="3;url=listAuctions.jsp">
            <%
        } else { 
            %>
            <h1>Leilão já está em acompanhamento.</h1>
            <meta http-equiv="Refresh" content="3;url=listAuctions.jsp">
            <%
        }
        %>
    </body>
</html>

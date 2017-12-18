<%-- 
    Document   : updateAuctionStatus
    Created on : 11/12/2017, 15:07:23
    Author     : Bruno
--%>

<%@page import="domain.Bid"%>
<%@page import="domain.Auction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="storage.AuctionsDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Atualizar Leilão</title>
    </head>
    <body>
        <%
        int auctionId = Integer.parseInt(request.getParameter("auctionId"));
        if(auctionId != 0){
            boolean newStatus = !request.getParameter("currentStatus").equals("true");
            boolean success = AuctionsDAO.getInstance().updateAuctionIdWithStatus(auctionId, newStatus);
            ArrayList<Auction> auctions = (ArrayList<Auction>)getServletContext().getAttribute("auctions");
            if(auctions == null) auctions = new ArrayList<Auction>();
            for(Auction a: auctions){
                if(a.getAuctionId() == auctionId){
                    a.setIsOpened(newStatus);
                }
            }
            getServletContext().setAttribute("auctions", auctions);
            if(newStatus){
                if(success){
                    %><h1>Leilão iniciado com sucesso.</h1><%
                } else {
                    %><h1>Não foi possível iniciar o leilão.</h1><%
                }
            } else {
                if(success){
                    Auction auction = AuctionsDAO.getInstance().getAuctionWithId(auctionId);
                    Bid finalBid = auction.getBids().get(auction.getBids().size() - 1);
                    pageContext.setAttribute("auctionId", auction.getAuctionId());
                    pageContext.setAttribute("bidId", finalBid.getBidId());
                    pageContext.setAttribute("username", finalBid.getUsername());
                    pageContext.setAttribute("description", auction.getProductDescription());
                    pageContext.setAttribute("minBid", auction.getMinBid());
                    pageContext.setAttribute("finalBid", finalBid.getBidValue());
                    %>
                    <h1>Leilão encerrado com sucesso.</h1>
                    <h2>Id do leilão: ${auctionId}</h2>
                    <h2>Id do lance: ${bidId}</h2>
                    <h2>Id do participante: ${username}</h2>
                    <h2>Descrição do item: ${description}</h2>
                    <h2>Lance mínimo: ${minBid}</h2>
                    <h2>Lance final: ${finalBid}</h2>
                    <%
                } else {
                    %><h1>Não foi possível encerrar o leilão.</h1><%
                }
            }
        } else {
            %><h1>Leilão não encontrado</h1><%
        }
        %>
        
        <h1></h1>
        <a href="admin.jsp"><input type="submit" value="Voltar" /></a>
    </body>
</html>

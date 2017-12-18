<%-- 
    Document   : participant
    Created on : 04/12/2017, 20:17:42
    Author     : Bruno
--%>

<%@page import="storage.UsersDAO"%>
<%@page import="domain.Auction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="storage.AuctionsDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Participante</title>
    </head>
    <body>
        <%
        String username = (String)request.getSession().getAttribute("username");
        pageContext.setAttribute("username", request.getSession().getAttribute("username"));
        %>
        <h1>Pagina de Participante: ${username}</h1>
        <h2>Leilões consultados</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Descrição</th>
                    <th>Lance mínimo</th>
                    <th>Lance atual</th>
                </tr>
            </thead>
            <tbody>
            <%
            ArrayList<Auction> userAuctions = (ArrayList<Auction>)session.getAttribute("auctions");
            ArrayList<Auction> allAuctions = (ArrayList<Auction>)getServletContext().getAttribute("auctions");
            ArrayList<Auction> auctions = new ArrayList<Auction>();
            if(userAuctions == null) userAuctions = new ArrayList<Auction>();
            if(allAuctions == null) allAuctions = new ArrayList<Auction>();
            for(Auction userAuction: userAuctions){
                for(Auction allAuction: allAuctions){
                    if(userAuction.getAuctionId() == allAuction.getAuctionId()){
                        auctions.add(allAuction);
                    }
                }
            }
            if(auctions == null || auctions.size() == 0){
                %><h3>Nenhum leilão consultado anteriormente.</h3><%
            } else {
                for(Auction auction : auctions){
                    pageContext.setAttribute("auctionId", auction.getAuctionId());
                    pageContext.setAttribute("auctionDescription", auction.getProductDescription());
                    pageContext.setAttribute("auctionMinBid", auction.getMinBid());
                    pageContext.setAttribute("auctionCurrentBid", auction.getBidValue());
                    pageContext.setAttribute("auctionOpened", auction.isOpened());
                    pageContext.setAttribute("auctionAction", auction.isOpened() ? "Encerrar" : "Iniciar");
                    %><tr>
                        <th>${auctionId}</th>
                        <th>${auctionDescription}</th>
                        <th>${auctionMinBid}</th>
                        <th>${auctionCurrentBid}</th>
                        <%
                        if(auction.isOpened()){
                            %>
                            <th>
                                <form action="submitBid.jsp" method="get">
                                    <input type="hidden" name="auctionId" value="${auctionId}" readonly="readonly"  />
                                    <input type="submit" value="Dar lance!" />
                                </form>
                            </th>
                            <%                                    
                        } 
                        %>
                    </tr><%
                }
            }
            %>
            </tbody>
        </table>
        <h1></h1>
        <form action="listAuctions.jsp">
            <input type="submit" value="Consultar Leilões" />
        </form>
        <h1></h1>
        <form action="logout.jsp">
            <input type="submit" value="Sair" />
        </form>
    </body>
</html>

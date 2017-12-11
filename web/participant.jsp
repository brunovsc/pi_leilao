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
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Pagina de participante</h1>
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
            ArrayList<Auction> auctions = (ArrayList<Auction>)session.getAttribute("auctions");
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

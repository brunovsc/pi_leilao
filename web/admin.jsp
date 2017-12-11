<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : admin
    Created on : 04/12/2017, 20:17:32
    Author     : Bruno
--%>

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
        <h1>Página de admin</h1>
        <h2>Leilões cadastrados</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Descrição</th>
                    <th>Lance mínimo</th>
                    <th>Lance atual</th>
                    <th>Ação</th>
                </tr>
            </thead>
            <tbody>
            <%
            ArrayList<Auction> auctions = AuctionsDAO.getInstance().getAuctions();
            if(auctions.size() == 0){
                %><h3>Nenhum leilão registrado.</h3><%
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
                        <th>
                            <form action="updateAuctionStatus.jsp" method="get">
                                <input type="hidden" name="auctionId" value="${auctionId}" readonly="readonly"  />
                                <input type="hidden" name="currentStatus" value="${auctionOpened}" readonly="readonly"  />
                                <input type="submit" value="${auctionAction}" />
                            </form>
                        </th>
                    </tr><%
                }
            }
            %>
            </tbody>
        </table>
        
          
        <h1></h1>  
        <form name="register_auction" action="registerAuction.jsp">
            <input type="submit" value="Eu vou fazer um" name="registerAuction" />       
        </form>
            
        <h1></h1>
        <form action="logout.jsp">
            <input type="submit" value="Sair" />
        </form>
    </body>
</html>

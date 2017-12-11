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
                    <th>Aberto</th>
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
                    pageContext.setAttribute("auctionOpened", auction.isOpened() ? "SIM" : "NÃO");
                    pageContext.setAttribute("auctionAction", auction.isOpened() ? "Encerrar" : "Iniciar");
                    %><tr>
                        <th>${auctionId}</th>
                        <th>${auctionDescription}</th>
                        <th>${auctionMinBid}</th>
                        <th>${auctionCurrentBid}</th>
                        <th>${auctionOpened}</th>
                        <th>
                            <form action="openAuction.jsp" method="get">
                                <input type="hidden" name="auctionId" value="${auctionId}" readonly="readonly"  />
                                <input type="submit" value="${auctionAction}" />
                            </form>
                        </th>
                    </tr><%
                }
            }
            %>
            </tbody>
        </table>
        
            
        <form name="register_auction" action="registerAuction.jsp">
            <table border="0">
                <tbody>
                <tr>
                    <td><input type="submit" value="Eu vou fazer um" name="registerAuction" /></td>
                </tr>
                </tbody>
            </table>
        </form>
    </body>
</html>

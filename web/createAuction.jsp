<%-- 
    Document   : createAuction
    Created on : 06/12/2017, 17:27:34
    Author     : a11311BCC009
--%>

<%@page import="storage.AuctionsDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Resultado</title>
    </head>
    <body>
        <%
        String description = request.getParameter("auctionDescription");
        if(description.length() <= 0){
            %>Descrição inválida<%
        } else {
            int initialBid = Integer.parseInt(request.getParameter("auctionInitialBid"));
            String message = AuctionsDAO.getInstance().createAuction(description, initialBid, initialBid, false);
            if(message.length() > 0){
                %><h1>${param.message}</h1><%
            } else {
                %><h1>Leilão registrado com sucesso</h1><%
            }
            %><meta http-equiv="Refresh" content="3;url=admin.jsp"><%
        }   
        %>
    </body>
</html>

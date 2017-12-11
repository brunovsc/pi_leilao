<%-- 
    Document   : updateAuctionStatus
    Created on : 11/12/2017, 15:07:23
    Author     : Bruno
--%>

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
            String st = request.getParameter("currentStatus");
            boolean status = request.getParameter("currentStatus").equals("true");
            boolean success = AuctionsDAO.getInstance().updateAuctionIdWithStatus(auctionId, status);
            if(status){
                if(success){
                    %><h1>Leilão encerrado com sucesso.</h1><%
                } else {
                    %>
                    <h1>Não foi possível encerrar o leilão.</h1>
                    <meta http-equiv="Refresh" content="3;url=admin.jsp">
                    <%
                }
            } else {
                if(success){
                    %>
                    <h1>Leilão iniciado com sucesso.</h1>
                    <meta http-equiv="Refresh" content="3;url=admin.jsp">
                    <%
                } else {
                    %>
                    <h1>Não foi possível iniciar o leilão.</h1>
                    <meta http-equiv="Refresh" content="3;url=admin.jsp">
                    <%
                }
            }
        } else {
            %>
            <h1>Leilão não encontrado</h1>
            <meta http-equiv="Refresh" content="3;url=admin.jsp">
            <%
        }
        %>
    </body>
</html>

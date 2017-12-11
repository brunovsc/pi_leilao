<%-- 
    Document   : registerAuction
    Created on : 06/12/2017, 17:25:25
    Author     : a11311BCC009
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Novo Leilão</title>
    </head>
    <body>
        <h1>Registrar Leilão</h1>
        <form name="create_auction" action="createAuction.jsp">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Descrição:</td>
                        <td><input type="text" name="auctionDescription" value="" /></td>
                    </tr>
                    <tr>
                        <td>Lance inicial:</td>
                        <td><input type="number" name="auctionInitialBid" value="0" /></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Leilão" name="create" /></td>
                    </tr>
                </tbody>
            </table>

        </form>
    </body>
</html>

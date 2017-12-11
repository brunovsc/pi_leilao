<%-- 
    Document   : index
    Created on : 29/11/2017, 17:19:54
    Author     : a11311BCC009
--%>

<%@page import="storage.ManagerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Leilão</title>
    </head>
    <body>
        <%ManagerDAO.getInstance();%>
        <form action="login.jsp">
            <input type="submit" value="Login" />
        </form>
        <form action="signup.jsp">
            <input type="submit" value="Cadastrar" />
        </form>
    </body>
</html>

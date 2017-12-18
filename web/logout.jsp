<%-- 
    Document   : logout
    Created on : 11/12/2017, 19:25:48
    Author     : Bruno
--%>

<%@page import="storage.UsersDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout</title>
    </head>
    <body>
        <%
        UsersDAO.getInstance().removeSession((String)request.getSession().getAttribute("username"), request);   
        session.invalidate();         
        %>
        <h1>Logout realizado com sucesso.</h1>
        <meta http-equiv="Refresh" content="3;url=index.jsp">
    </body>
</html>

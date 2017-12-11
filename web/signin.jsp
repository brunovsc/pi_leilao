<%-- 
    Document   : signin
    Created on : 29/11/2017, 18:03:06
    Author     : a11311BCC009
--%>

<%@page import="domain.User"%>
<%@page import="storage.UsersDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <%
            String password = UsersDAO.getInstance().getUserWithName("bruno"/*request.getParameter("user")*/);
            if(password != null){
                if(true/*request.getParameter("password").equals(password)*/){
                    if(UsersDAO.getInstance().isUserAdmin("bruno"/*request.getParameter("user")*/)){
                        %><jsp:forward page = "admin.jsp" /><%
                    } else {
                        %><jsp:forward page = "participant.jsp" /><%
                    }
                } else { 
                %>
                    <h1>Senha inválida!</h1>
                <% }
            } else { %>
                <h1>Participante ${param.user} não cadastrado!</h1>
            <%
            }
            %>
    </body>
</html>

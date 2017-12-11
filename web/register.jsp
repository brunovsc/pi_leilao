<%-- 
    Document   : register
    Created on : 04/12/2017, 14:01:52
    Author     : a11311BCC009
--%>

<%@page import="storage.ParticipantsDAO"%>
<%@page import="storage.UsersDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de usuário</title>
    </head>
    <body>
        <%
        String username = request.getParameter("username");
        if(username.length() >= 4){
            if(request.getParameter("password").length() >= 4){
                boolean isAdmin = request.getParameter("admin") != null;
                String admin = isAdmin ? "1" : "0";
                String message = UsersDAO.getInstance().createUser(username, request.getParameter("password"), admin);
                if(message != null){
                    %><h1>${param.message}</h1><%
                } else {
                    if(!isAdmin){
                        %>
                        <form action="registerParticipant.jsp">
                            <table border="0">
                                <tbody>
                                    <tr>
                                        <td>Login:</td>
                                        <td><input type="text" name="name" value="${param.username}" disabled="true"/></td>
                                    </tr>
                                    <tr>
                                        <td>Nome:</td>
                                        <td><input type="text" name="name" value="" /></td>
                                    </tr>
                                    <tr>
                                        <td><input type="submit" value="Salvar" name="name" /></td>
                                    </tr>
                                </tbody>
                            </table>

                        </form>
                        <%
                    } else {
                        %>
                        <h1>Usuario administrador "${param.username}" registrado com sucesso.</h1>
                        <meta http-equiv="Refresh" content="3;url=admin.jsp">
                        <%
                    }
                }
            } else {
                %><h1>A senha precisa ter, no mínimo, 4 caracteres.</h1><%   
            }
        } else {
            %><h1>O nome de usuário precisa ter, no mínimo, 4 caracteres.</h1><%  
        }
        %>        
    </body>
</html>

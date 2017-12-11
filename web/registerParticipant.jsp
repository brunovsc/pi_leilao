<%-- 
    Document   : registerParticipant
    Created on : 04/12/2017, 21:12:38
    Author     : Bruno
--%>

<%@page import="storage.UsersDAO"%>
<%@page import="storage.ParticipantsDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Participante</title>
    </head>
    <body>
        <%
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        if(name.length() > 0){
            String participantId = ParticipantsDAO.getInstance().createParticipant(name, username);
            if(participantId == null){
                %><h1>${param.message}</h1><%
            } else {
                UsersDAO.getInstance().saveSession(username, request);
                %>
                <h1>Usuario participante "${param.name}" registrado com sucesso.</h1>
                <meta http-equiv="Refresh" content="3;url=participant.jsp">
                <%
            }
        } else {
            %><h1>O nome precisa ter, no mínimo, 1 caracter.</h1><%   
        }
        %>
    </body>
</html>

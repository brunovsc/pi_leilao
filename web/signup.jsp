<%-- 
    Document   : signup
    Created on : 29/11/2017, 17:27:57
    Author     : a11311BCC009
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Usuário</title>
    </head>
    <body>
        <form action="register.jsp">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Nome do usuário: </td>
                        <td><input type="text" name="username" value="" /></td>
                    </tr>
                    <tr>
                        <td>Senha:</td>
                        <td><input type="password" name="password" value="" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="checkbox" name="admin" value="off" />Admin</td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Registrar" name="register" /></td>
                    </tr>
                </tbody>
            </table>
        </form>
    </body>
</html>

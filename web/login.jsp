<%-- 
    Document   : login
    Created on : 29/11/2017, 17:26:56
    Author     : a11311BCC009
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <form action="signin.jsp">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Usuario:</td>
                        <td><input type="text" name="user" value="" /></td>
                    </tr>
                    <tr>
                        <td>Senha:</td>
                        <td><input type="password" name="password" value="" /></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Entrar" /></td>
                    </tr>
                </tbody>
            </table>
        </form>
    </body>
</html>

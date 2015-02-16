
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <link type="text/css" href="css/1.css" rel="stylesheet" media="screen" />
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
     <h:body>
        <div id="container">
            <header>
                <h1>Gebrauchtwagenbörse</h1>
            </header>
            <nav>
                
            </nav>
            <aside>
                
            </aside>
            <section id="content">
           <% 
                if (request.getParameter("errorreg") != null)
                                out.println("Username schon vergeben oder Felder leer");
            %>
           <form method="post" action="registration.jsp">
            <center>
            <table border="0" width="30%" cellpadding="5">
                <thead>
                    <tr>
                        <th colspan="2">Registrieren</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Vorname</td>
                        <td><input type="text" name="fname" value="" /></td>
                    </tr>
                    <tr>
                        <td>Nachname</td>
                        <td><input type="text" name="lname" value="" /></td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td><input type="text" name="email" value="" /></td>
                    </tr>
                    <tr>
                        <td>User Name</td>
                        <td><input type="text" name="uname" value="" /></td>
                    </tr>
                    <tr>
                        <td>Passwort</td>
                        <td><input type="password" name="pass" value="" /></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Absenden" /></td>
                    </tr>
                </tbody>
            </table>
            </center>
        </form>
            </section>
            <footer>
                
            </footer>
        </div>
        
    </h:body>
</html>

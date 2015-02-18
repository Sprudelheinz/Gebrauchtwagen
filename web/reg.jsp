
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <link type="text/css" href="css/1.css" rel="stylesheet" media="screen" />
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gebrauchtwagenbörse</title>
        <link rel="shortcut icon" href="img/favicon.ico">
    </head>
     <h:body>
        <div id="container">
            <header>
                <h1><a href="index.jsp">Gebrauchtwagenbörse</a></h1>
            </header>
            <nav>
                <div id="navdiv"><a href="index.jsp">Startseite</a></div>  
            </nav>
             <aside>                
                <%@include file="aside.jsp" %>
             </aside>
            <section id="content">
           <% 
                if (request.getParameter("errorreg") != null)
                                out.println("Username schon vergeben oder Felder leer");                
                if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {               
            %>
           <form method="post" action="registration.jsp">
            <center id="divrund">
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
                        <td>User Name</td>
                        <td><input type="text" name="uname"  value="" /></td>
                    </tr>
                    <tr>
                        <td>Passwort</td>
                        <td><input type="password" name="pass" value="" /></td>
                    </tr>
                    <tr>
                        <td>Stadt</td>
                        <td><input type="text" name="stadt" value="" /></td>
                    </tr>
                    <tr>
                        <td>Telefonnummer</td>
                        <td><input type="text" name="telefonnummer" value="" /></td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td><input type="text" name="email" value="" /></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Absenden" /></td>
                    </tr>
                </tbody>
            </table>
            </center>
        </form>
            <% } else { out.print("Schon Registriert"); } %>
            </section>
            <footer>
                
            </footer>
        </div>
        
    </h:body>
</html>

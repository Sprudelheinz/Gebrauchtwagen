
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
                <h1><a href="index.jsp">Gebrauchtwagenbörse</a></h1>
            </header>
            <nav>
                
            </nav>
            <aside>
                 <%
                if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
                %>
               <form method="post" action="login.jsp">
                 <input type="hidden" name="login" value="reg"/>
                <center>
                    <table border="0" width="30%" cellpadding="3">
                        <thead>
                            <tr>
                                <th colspan="2">Login</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>User</td>
                                <td><input type="text" name="uname" value="" /></td>
                            </tr>
                            <tr>
                                <td>Passwort</td>
                                <td><input type="password" name="pass" value="" /></td>
                            </tr>
                            <tr>
                                <td><input type="submit" value="Login" /></td>
                            </tr>
                            <tr>
                                <td colspan="2"><a href="reg.jsp">Registrieren</a></td>
                            </tr>
                            <% 
                            if (request.getParameter("loginerror") != null)
                                out.println("Falsche Anmeldedaten");
                            %>
                        </tbody>
                        </table>
                    </center>
                </form>
               <% } else {%>Hallo <%=session.getAttribute("username")%>
              <br> <a href='logout.jsp?logout=reg'>Log out</a><br>
                    <a href='settings.jsp'>Einstellungen</a>
               <%}%>
               <a href="newcar.jsp">Neues Angebot</a>
            </aside>
            <section id="content">
           <% 
                if (request.getParameter("errorreg") != null)
                                out.println("Username schon vergeben oder Felder leer");                
                if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {               
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
                        <td>User Name</td>
                        <td><input type="text" name="uname" value="" /></td>
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

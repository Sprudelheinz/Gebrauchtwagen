
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
              <br> <a href='logout.jsp'>Log out</a><br>
                    <a href='settings.jsp'>Einstellungen</a>
               <%}%>
               <a href="newcar.jsp">Neues Angebot</a>
            </aside>
            <section id="content">
                 <%
                if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
                %>
                Nicht angemeldet. Bitte melden sie sich an
                <% } else {%>
                <jsp:useBean id="user" class="classes.user" /> 
                <% user.user(Integer.parseInt(session.getAttribute("userid").toString())); %>
                <form method="post" action="settings.jsp">
                    <center>
                        <table border="0" width="30%" cellpadding="5">
                            <thead>
                                <tr>
                                    <th colspan="2">Benutzerdaten ändern</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Vorname</td>
                                    <td><input type="text" name="fname" value="${user.vname}" /></td>
                                </tr>
                                <tr>
                                    <td>Nachname</td>
                                    <td><input type="text" name="lname" value="${user.nachname}" /></td>
                                </tr>
                                <tr>
                                    <td>Email</td>
                                    <td><input type="text" name="email" value="${user.email}" /></td>
                                </tr>
                                <tr>
                                    <td>User Name</td>
                                    <td><input type="text" name="uname" value="${user.username}" /></td>
                                </tr>
                                <tr>
                                    <td>Passwort</td>
                                    <td><input type="password" name="pass" value="" /></td>
                                </tr>
                                <tr>
                                    <td><input type="submit" value="Ändern" /></td>
                                </tr>
                            </tbody>
                        </table>
                    </center>
                </form>
                
                
                <%}%>
                
            </section>
            <footer>
                
            </footer>
        </div>
        
    </h:body>
</html>
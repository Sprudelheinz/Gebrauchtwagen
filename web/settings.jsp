
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
                if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
                %>
                Nicht angemeldet. Bitte melden sie sich an
                <% } else {%>
                <jsp:useBean id="user" class="classes.user" /> 
                <% 
                    user.user(Integer.parseInt(session.getAttribute("userid").toString())); 
                    
                    String userneu = request.getParameter("uname");   
                    String fname = request.getParameter("fname");
                    String lname = request.getParameter("lname");
                    String email = request.getParameter("email");
                    String stadt = request.getParameter("stadt");
                    String telefonnummer = request.getParameter("telefonnummer");
                    String passold = request.getParameter("passold");
                    String passnew = request.getParameter("passnew");
                    if(!request.getParameterMap().isEmpty())
                    {
                        if(!userneu.equals(user.username) || !fname.equals(user.vname) || !lname.equals(user.nachname) || !stadt.equals(user.stadt) || !email.equals(user.email) || !telefonnummer.equals(user.telefonnummer) || (passold != null && passnew != null)  )
                            out.print(user.changeuserdata(userneu, fname, lname, email, stadt, telefonnummer, passold, passnew));
                    }
                %>
                <form method="post" action="settings.jsp">
                    <div id="divrund">
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
                                    <td>Stadt</td>
                                    <td><input type="text" name="stadt" value="${user.stadt}" /></td>
                                </tr>
                                 <tr>
                                    <td>Telefonnummer</td>
                                    <td><input type="text" name="telefonnummer" value="${user.telefonnummer}" /></td>
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
                                    <td>Passwort alt</td>
                                    <td><input type="password" name="passold" value="" /></td>
                                </tr>
                                <tr>
                                    <td>Passwort neu</td>
                                    <td><input type="password" name="passnew" value="" /></td>
                                </tr>
                                <tr>
                                    <td><input type="submit" value="Ändern" /></td>
                                </tr>
                            </tbody>
                        </table>
                    </center>
                  <div>
                </form>
                
                
                <%}%>
                
            </section>
            <footer>
                
            </footer>
        </div>
        
    </h:body>
</html>

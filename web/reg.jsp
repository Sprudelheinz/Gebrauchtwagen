
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
                <a href="index.jsp"><img src="img/logo-header.png"/></a>
            </header>
            <nav>
                <div id="navdiv"><a href="index.jsp">Startseite</a></div>  
            </nav>
             <aside>                
                <%@include file="aside.jsp" %>
             </aside>
            <section id="content">
           <% 
                if (request.getParameter("errormessage") != null)
                    out.println(request.getParameter("errormessage"));                
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
                        <td>Vorname*</td>
                        <td><input type="text" name="fname" value="<%if(session.getAttribute("Vorname") != null) out.print(session.getAttribute("Vorname"));  %>" /></td>
                    </tr>
                    <tr>
                        <td>Nachname*</td>
                        <td><input type="text" name="lname" value="<%if(session.getAttribute("Nachname") != null) out.print(session.getAttribute("Nachname"));%>" /></td>
                    </tr>                   
                    <tr>
                        <td>User Name*</td>
                        <td><input type="text" name="uname"  value="<%if(session.getAttribute("User") != null) out.print(session.getAttribute("User"));%>" /></td>
                    </tr>
                    <tr>
                        <td>Passwort*</td>
                        <td><input type="password" name="pass" /></td>
                    </tr>
                    <tr>
                        <td>Stadt*</td>
                        <td><input type="text" name="stadt" value="<%if(session.getAttribute("Stadt") != null) out.print(session.getAttribute("Stadt"));%>" /></td>
                    </tr>
                    <tr>
                        <td>Telefonnummer*</td>
                        <td><input type="text" name="telefonnummer" value="<%if(session.getAttribute("Telefon") != null) out.print(session.getAttribute("Telefon"));%>" /></td>
                    </tr>
                    <tr>
                        <td>Email*</td>
                        <td><input type="text" name="email" value="<%if(session.getAttribute("EMail") != null) out.print(session.getAttribute("EMail"));%>" /></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Absenden" /></td>
                    </tr>
                    <tr>
                        <td>*Pflichtfelder</td>
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

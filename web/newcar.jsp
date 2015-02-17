<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

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
                 <input type="hidden" name="login" value="newcar"/>
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
              <br> <a href='logout.jsp?logout=newcar'>Log out</a><br>
                    <a href='settings.jsp'>Einstellungen</a>
               <%}%>
               <a href="newcar.jsp">Neues Angebot</a>
            </aside>
            <section id="content">
                <article>
                    <form name="newcar" method="post"  action="">
                        <div>
                            <div>
                            <br>Fahrzeugzustand</br>
                            <%if(request.getParameter("new") != null)
                                out.println("<input type=\"checkbox\" checked=\"true\" name=\"new\" id=\"new\" onchange=\"onchange=document.newcar.submit()\" />Neu");
                            else 
                                out.println("<input type=\"checkbox\" name=\"new\" id=\"new\" onchange=\"onchange=document.newcar.submit()\" />Neu"); %>
                            </div>
                            <div>
                                Marke                              
                                <jsp:useBean id="dropdown" class="classes.dropdownlist" scope="request" />                               
                                <%
                                    out.println(dropdown.ddmarke(request.getParameter("Marke"),"newcar"));
                                %>
                            
                            </div>
                            <div>
                                Modell
                                <%
                                    out.println(dropdown.ddmodell(request.getParameter("Marke"),request.getParameter("Modell")));
                                %>
                              
                            </div>
                            <div>
                                Erstzulassung:
                                <select name="EZMonat">
                                    <option value="1" name="Januar"/>
                                    <option value="2" name="Februar"/>
                                    <option value="3" name="März"/>
                                    <option value="4" name="April"/>
                                    <option value="5" name="Mai"/>
                                    <option value="6" name="Juni"/>
                                    <option value="7" name="Juli"/>
                                    <option value="8" name="August"/>
                                    <option value="9" name="September"/>
                                    <option value="10" name="Oktober"/>
                                    <option value="11" name="November"/>
                                    <option value="12" name="Dezember"/>
                                </select>
                            </div>
                            <div>
                                Baujahr:
                                <input type="text" name="baujahr"/>
                            </div>
                            <div>
                                Preis
                                <input type="text" name="preis">
                            </div>
                            <div>
                                Kilometer:
                                <input type="number" name="KM" min="0" max="99999999">
                            </div>
                            <div>
                                Kraftstoffart:
                                <select name="kraftstoffart">
                                    <option value="Benzin">Benzin</option>
                                    <option value="Diesel">Diesel</option>
                                    <option value="Elektro">Elektro</option>
                                    <option value="Gas">Gas</option>
                                    <option value="Hybrid">Hybrid</option>
                                </select>
                            </div>
                            <div>
                                Hubraum
                                <input type="number" name="hubraum" min="0" max="99999999">
                            </div>
                            <div>
                                PS
                                <input type="number" name="PS" min="0" max="99999999">
                            </div>
                            <div>
                                TÜV
                                <input type="checkbox" name="tuv">
                            </div>
                            <div>
                                TÜV bis:
                                <input type="text" name="tuvbis"/>
                            </div>
                            <%
                                 if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
                            %>
                            <div>
                                <br>
                               Kontaktdaten:                          
                            </div>
                            <div>
                                Name:
                                <input type="text" name="name"/>
                            </div>
                            <div>
                                Stadt:
                                <input type="text" name="stadt"/>
                            </div>
                            <div>
                                Telefonnummer:
                                <input type="text" name="telefonnummer"/>
                            </div>
                            <div>
                                E-Mail Adresse:
                                <input type="text" name="email"/>
                            </div>
                            <% } %>
                            <input type="submit" value="senden" formaction="newcardatatodb"><br>
                        </div>

                    </form>
                </article>
            </section>
            <footer>
                
            </footer>
        </div>
        
    </h:body>
</html>

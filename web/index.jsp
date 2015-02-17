
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*,classes.search"%>

<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://java.sun.com/jsf/html">
    <link type="text/css" href="css/1.css" rel="stylesheet" media="screen" />
    <h:body>
        <div id="container">
            <header>
                <h1><a href="index.jsp">Gebrauchtwagenbörse</a></h1>
            </header>
            <nav>
                <form name="search">
                    <div>
                        <div>
                        <br>Fahrzeugzustand</br>
                        <input type="hidden" name="search" value="false">
                        <input type="checkbox" name="new"/>Neu
                        </div>
                        <div>                            
                            Marke                            
                            <jsp:useBean id="dropdown" class="classes.dropdownlist" />                               
                            <%
                                out.println(dropdown.ddmarke(request.getParameter("Marke"),"search"));
                            %>
                            
                        </div>
                        <div>
                            Modell                           
                            <%
                                out.println(dropdown.ddmodell(request.getParameter("Marke"),request.getParameter("Modell")));
                            %>
                            
                        </div>
                        <div>
                            Erstzulassung ab:
                            <select name="minFirstRegistrationDate" placeholder="Beliebig">
                                <option value="0">Beliebig</option>
                                <option value="2015-01-01">2015</option>
                                <option value="2014-01-01">2014</option>
                                <option value="2013-01-01">2013</option>
                                <option value="2012-01-01">2012</option>
                                <option value="2011-01-01">2011</option>
                                <option value="2010-01-01">2010</option>
                                <option value="2009-01-01">2009</option>
                                <option value="2008-01-01">2008</option>
                                <option value="2007-01-01">2007</option>
                                <option value="2006-01-01">2006</option>
                                <option value="2005-01-01">2005</option>
                                <option value="2004-01-01">2004</option>
                                <option value="2003-01-01">2003</option>
                                <option value="2002-01-01">2002</option>
                                <option value="2001-01-01">2001</option>
                                <option value="2000-01-01">2000</option>
                                <option value="1999-01-01">1999</option>
                                <option value="1998-01-01">1998</option>
                                <option value="1997-01-01">1997</option>
                                <option value="1996-01-01">1996</option>
                                <option value="1995-01-01">1995</option>
                                <option value="1994-01-01">1994</option>
                                <option value="1993-01-01">1993</option>
                                <option value="1992-01-01">1992</option>
                                <option value="1991-01-01">1991</option>
                                <option value="1990-01-01">1990</option>
                                <option value="1985-01-01">1985</option>
                                <option value="1980-01-01">1980</option>
                                <option value="1975-01-01">1975</option>
                                <option value="1970-01-01">1970</option>
                                <option value="1965-01-01">1965</option>
                                <option value="1960-01-01">1960</option>
                                <option value="1900-01-01">1900</option>
                            </select>
                        </div>
                        <div>
                            Kilometer bis
                            <select name="maxMileage" placeholder="Beliebig">
                                <option value="0">Beliebig</option>
                                <option value="5000">5.000</option>
                                <option value="10000">10.000</option>
                                <option value="20000">20.000</option>
                                <option value="30000">30.000</option>
                                <option value="40000">40.000</option>
                                <option value="50000">50.000</option>
                                <option value="60000">60.000</option>
                                <option value="70000">70.000</option>
                                <option value="80000">80.000</option>
                                <option value="90000">90.000</option>
                                <option value="100000">100.000</option>
                                <option value="125000">125.000</option>
                                <option value="150000">150.000</option>
                                <option value="200000">200.000</option>
                            </select>
                        </div>
                        <input type="submit" value="senden" onclick="document.search.search.value=true"><br>
                    </div>
                    
                </form>
            </nav>
            <aside>
             <%
                if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
             %>
               <form method="post" action="login.jsp">
                 <input type="hidden" name="login" value="index"/>
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
              <br> <a href='logout.jsp?logout=index'>Log out</a><br>
                    <a href='settings.jsp'>Einstellungen</a>
               <%}%>
               <a href="newcar.jsp">Neues Angebot</a>
            </aside>
            <section id="content">
                <% 
                    if(request.getParameter("search")!=null && request.getParameter("search").equals("true"))
                    {
                        search s = new search();
                        String n="",u="",mo="",ma="";
                        if(request.getParameter("new") != null)
                             n = request.getParameter("new");
                        if(request.getParameter("Modell") != null)
                            mo = request.getParameter("Modell");
                        if(request.getParameter("Marke") != null)
                            ma = request.getParameter("Marke");
                        out.print(s.showSearchResult(n,ma,mo));      
                    }                                       
                %>
            </section>
            <footer>
                
            </footer>
        </div>
        
    </h:body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*,java.util.Date"%>

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
                 Nicht eingeloggt. Bitte melden Sie sich an.
                 <% } else { %>
                <article>
                    <% if(request.getParameter("errorreg") != null) {out.println(request.getParameter("errorreg"));} %>
                    <form name="newcar" method="post"  action="">
                        <div id="divrund">
                            <table>                               
                                <tr>
                                    <th>Fahrzeugdaten:</th>
                                </tr>
                                <tr>
                                    <td>Typ</td>
                                    <td>
                                        <select name="typ" onchange="document.newcar.submit()">
                                            <option <%if(request.getParameter("typ")!=null&&request.getParameter("typ").equals("0")){out.print("selected");}%> value="0">Auto</option>
                                            <option <%if(request.getParameter("typ")!=null&&request.getParameter("typ").equals("1")){out.print("selected");}%> value="1">Motorrad</option>    
                                        </select>
                                    <td>
                                </tr>
                                <tr>
                                    <td>Fahrzeugzustand</td>
                                    <td>
                                    <%
                                    String neu = request.getParameter("new");      
                                    if(request.getParameter("new") != null){
                                        out.println("<input type=\"checkbox\" checked=\"true\" name=\"new\" id=\"new\" onchange=\"onchange=document.newcar.submit()\" />Neu");
                                    }
                                    else 
                                        out.println("<input type=\"checkbox\" name=\"new\" id=\"new\" onchange=\"onchange=document.newcar.submit()\" />Neu"); %>
                                    </td>
                                </tr>
                                <tr>                                                                  
                                    <td>Marke:*</td>                             
                                    <td>
                                        <jsp:useBean id="dropdown" class="classes.dropdownlist" scope="request" />                               
                                        <%
                                            String typ="";
                                            if(request.getParameter("typ") != null)
                                                typ = request.getParameter("typ");
                                            if(typ.equals("") || typ.equals("0") )
                                                out.println(dropdown.ddmarke(request.getParameter("Marke"),"newcar"));
                                            if(typ.equals("1"))
                                                out.println(dropdown.ddmarkemotorrad(request.getParameter("Marke"),"newcar"));
                                            Date date = new Date();
                                            SimpleDateFormat output = new SimpleDateFormat("yyyy");
                                        %>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Modell:*</td>
                                    <td>
                                        <%
                                            if(typ.equals("") || typ.equals("0") )
                                                out.println(dropdown.ddmodell(request.getParameter("Marke"),request.getParameter("Modell")));
                                            if(typ.equals("1"))
                                                out.println(dropdown.ddmodellmotorrad(request.getParameter("Marke"),request.getParameter("Modell")));
                                        %>
                                    </td>
                                </tr>
                                <% if(neu == null){ %>
                                <tr>                         
                                    <td>Erstzulassung:*</td>
                                    <td>
                                    <select name="EZMonat">
                                        <option value="1">Januar</option> 
                                        <option value="2">Februar</option> 
                                        <option value="3">März</option> 
                                        <option value="4">April</option> 
                                        <option value="5">Mai</option> 
                                        <option value="6">Juni</option> 
                                        <option value="7">Juli</option> 
                                        <option value="8">August</option> 
                                        <option value="9">September</option>
                                        <option value="10">Oktober</option> 
                                        <option value="11">November</option> 
                                        <option value="12">Dezember</option> 
                                    </select>
                                    
                                        <input type="number" name="EZJahr" min="1900" max="<%= output.format(date) %>" />
                                    </td>
                                </tr>
                                <%}%>
                                <tr>
                                    <td>Preis:*</td>
                                    <td><input type="text" name="preis"></td>
                                </tr>
                                <% if(neu == null){ %>
                                <tr>
                                    <td>Kilometer:*</td>
                                    <td><input type="number" name="KM" min="0" max="99999999"></td>
                                </tr> 
                                <%}%>
                                <tr>
                                    <td>Kraftstoffart:*</td>
                                    <td>
                                        <select name="kraftstoffart">
                                            <option value="Benzin">Benzin</option>
                                            <option value="Diesel">Diesel</option>
                                            <option value="Elektro">Elektro</option>
                                            <option value="Gas">Gas</option>
                                            <option value="Hybrid">Hybrid</option>
                                        </select>
                                    </td>
                                </tr> 
                                <tr>
                                    <td>Hubraum:*</td>
                                    <td><input type="number" name="hubraum" min="0" max="99999999"></td>
                                </tr>
                                <tr>
                                    <td>Leistung (PS):*</td>
                                    <td><input type="number" name="PS" min="0" max="99999999"></td>
                                </tr>
                                <% if(typ.equals("") || typ.equals("0") ) { %>
                                <tr>
                                    <td>Anzahl der Türen:</td>
                                    <td>
                                        <select name="anzturen">
                                            <option value="2/3">2/3</option>
                                            <option value="4/5">4/5</option>
                                            <option value="6/7">6/7</option>
                                        </select>
                                    </td>
                                </tr>  
                                <% } %>
                                <tr>
                                    <td>TÜV</td>
                                    <td><input type="checkbox" name="tuv"></td>
                                </tr>
                                <tr>                         
                                    <td>TÜV bis:</td>
                                    <td>
                                        <select name="TUVMonat">
                                            <option value="1">Januar</option> 
                                            <option value="2">Februar</option> 
                                            <option value="3">März</option> 
                                            <option value="4">April</option> 
                                            <option value="5">Mai</option> 
                                            <option value="6">Juni</option> 
                                            <option value="7">Juli</option> 
                                            <option value="8">August</option> 
                                            <option value="9">September</option>
                                            <option value="10">Oktober</option> 
                                            <option value="11">November</option> 
                                            <option value="12">Dezember</option> 
                                        </select>
                                   
                                        <input type="number" name="TUVJahr" min="<%= output.format(date) %>" max="2500" />
                                    </td>
                                </tr> 
                                <tr>
                                    <td>Beschreibung:</td>
                                    <td><textarea name="beschreibung" cols="27" rows="10"> </textarea></td>
                                </tr>
                            <tr>
                                <td><input type="submit" value="senden" formaction="newcardatatodb"></td>
                            <tr>
                            </table>
                         </div>

                    </form>
                </article>
                  <% }     %>             
            </section>
            <footer>
                
            </footer>
        </div>
        
    </h:body>
</html>

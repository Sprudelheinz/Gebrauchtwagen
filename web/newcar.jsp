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
                <article>
                    <form name="newcar" method="post"  action="">
                        <div id="divrund">
                            <table>
                                <tr>
                                    <th>Fahrzeugdaten:</th>
                                </tr>
                                <tr>
                                    <td>Fahrzeugzustand</td>
                                    <td>
                                    <%if(request.getParameter("new") != null)
                                        out.println("<input type=\"checkbox\" checked=\"true\" name=\"new\" id=\"new\" onchange=\"onchange=document.newcar.submit()\" />Neu");
                                    else 
                                        out.println("<input type=\"checkbox\" name=\"new\" id=\"new\" onchange=\"onchange=document.newcar.submit()\" />Neu"); %>
                                    </td>
                                </tr>
                                <tr>                                                                  
                                    <td>Marke:</td>                             
                                    <td>
                                        <jsp:useBean id="dropdown" class="classes.dropdownlist" scope="request" />                               
                                        <%
                                            out.println(dropdown.ddmarke(request.getParameter("Marke"),"newcar"));
                                            Date date = new Date();
                                            SimpleDateFormat output = new SimpleDateFormat("yyyy");
                                        %>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Modell:</td>
                                    <td>
                                        <%
                                            out.println(dropdown.ddmodell(request.getParameter("Marke"),request.getParameter("Modell")));
                                        %>
                                    </td>
                                </tr>
                                <tr>                         
                                    <td>Erstzulassung:</td>
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
                                <tr>
                                    <td>Preis:</td>
                                    <td><input type="text" name="preis"></td>
                                </tr>
                                <tr>
                                    <td>Kilometer:</td>
                                    <td><input type="number" name="KM" min="0" max="99999999"></td>
                                </tr> 
                                <tr>
                                    <td>Kraftstoffart:</td>
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
                                    <td>Hubraum:</td>
                                    <td><input type="number" name="hubraum" min="0" max="99999999"></td>
                                </tr>
                                <tr>
                                    <td>PS:</td>
                                    <td><input type="number" name="PS" min="0" max="99999999"></td>
                                </tr>
                                <tr>
                                    <td>Anzahl der Türen:</td>
                                    <td>
                                        <select name="anzturen">
                                            <option value="0">Bitte wählen</option>
                                            <option value="'2/3'">2/3</option>
                                            <option value="'4/5'">4/5</option>
                                            <option value="'6/7'">6/7</option>
                                        </select>
                                    </td>
                                </tr>                              
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
                            <%
                                 if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
                            %>
                            <tr>
                                <th>Kontaktdaten:</th>
                            </tr>
                            <tr>
                                <td>Name:</td>
                                <td><input type="text" name="name"/></td>
                            </tr>
                            <tr>
                                <td>Stadt:</td>
                                <td><input type="text" name="stadt"/></td>
                            </tr>
                            <tr>
                                <td>Telefonnummer:</td>
                                <td><input type="text" name="telefonnummer"/></td>
                            </tr>
                            <tr>
                                <td>E-Mail Adresse:</td>
                                <td><input type="text" name="email"/></td>
                            </tr>
                            <% } %>
                            <tr>
                                <td><input type="submit" value="senden" formaction="newcardatatodb"></td>
                            <tr>
                            </table>
                         </div>

                    </form>
                </article>
            </section>
            <footer>
                
            </footer>
        </div>
        
    </h:body>
</html>

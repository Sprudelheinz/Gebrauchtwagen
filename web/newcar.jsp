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
                            <div>
                            <br>Fahrzeugzustand</br>
                            <%if(request.getParameter("new") != null)
                                out.println("<input type=\"checkbox\" checked=\"true\" name=\"new\" id=\"new\" onchange=\"onchange=document.newcar.submit()\" />Neu");
                            else 
                                out.println("<input type=\"checkbox\" name=\"new\" id=\"new\" onchange=\"onchange=document.newcar.submit()\" />Neu"); %>
                            </div>
                            <div>
                                Marke: <br>                              
                                <jsp:useBean id="dropdown" class="classes.dropdownlist" scope="request" />                               
                                <%
                                    out.println(dropdown.ddmarke(request.getParameter("Marke"),"newcar"));
                                    Date date = new Date();
                                    SimpleDateFormat output = new SimpleDateFormat("yyyy");
                                %>
                            
                            </div>
                            <div>
                                Modell: <br>
                                <%
                                    out.println(dropdown.ddmodell(request.getParameter("Marke"),request.getParameter("Modell")));
                                %>
                              
                            </div>
                            <div>
                                Erstzulassung: <br>
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
                            </div>
                            <div>
                                Preis: <br>
                                <input type="text" name="preis">
                            </div>
                            <div>
                                Kilometer: <br>
                                <input type="number" name="KM" min="0" max="99999999">
                            </div>
                            <div>
                                Kraftstoffart: <br>
                                <select name="kraftstoffart">
                                    <option value="Benzin">Benzin</option>
                                    <option value="Diesel">Diesel</option>
                                    <option value="Elektro">Elektro</option>
                                    <option value="Gas">Gas</option>
                                    <option value="Hybrid">Hybrid</option>
                                </select>
                            </div>
                            <div>
                                Hubraum <br>
                                <input type="number" name="hubraum" min="0" max="99999999">
                            </div>
                            <div>
                                PS <br>
                                <input type="number" name="PS" min="0" max="99999999">
                            </div>
                            <div>
                                TÜV <br>
                                <input type="checkbox" name="tuv">
                            </div>
                            <div>
                                TÜV bis: <br>
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
                            </div>
                            <%
                                 if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
                            %>
                            <div>
                                <br>
                               Kontaktdaten:    <br>                       
                            </div>
                            <div>
                                Name: <br>
                                <input type="text" name="name"/>
                            </div>
                            <div>
                                Stadt: <br>
                                <input type="text" name="stadt"/>
                            </div>
                            <div>
                                Telefonnummer: <br>
                                <input type="text" name="telefonnummer"/>
                            </div>
                            <div>
                                E-Mail Adresse: <br>
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

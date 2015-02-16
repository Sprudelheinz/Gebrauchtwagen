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
                
            </aside>
            <section id="content">
                <article>
                    <form name="newcar" action="">
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
                             <input type="text" name="erstzulassung"/>
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
                            <input type="submit" value="senden" formaction="newcartodb.jsp"><br>
                        </div>

                    </form>
                </article>
            </section>
            <footer>
                
            </footer>
        </div>
        
    </h:body>
</html>

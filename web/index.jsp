
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="classes.search"%>

<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://java.sun.com/jsf/html">
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
                <%                     
                    if(request.getParameter("Message")!=null) { %>
                <h2> <% out.print(request.getParameter("Message")); }%> </h2>
            </header>
            <nav>
                <form name="search">
                    <div id="divrund">
                        <% 
                            
                        %>
                        
                        <div>
                            Typ<br>
                            <select name="typ" onchange="document.search.submit()">
                                <option <%if(request.getParameter("typ")!=null&&request.getParameter("typ").equals("0")){out.print("selected");}%> value="0">Auto</option>
                                <option <%if(request.getParameter("typ")!=null&&request.getParameter("typ").equals("1")){out.print("selected");}%> value="1">Motorrad</option>    
                            </select>
                        </div>
                        <div>
                            Fahrzeugzustand</br>
                            <input type="hidden" name="search" value="false">
                            <input type="checkbox" name="new"/>Neu
                        </div>
                        <div>                            
                            Marke:<br>                            
                            <jsp:useBean id="dropdown" class="classes.dropdownlist" />                               
                            <%                              
                                String typ="";
                                if(request.getParameter("typ") != null)
                                    typ = request.getParameter("typ");
                                if(typ.equals("") || typ.equals("0") )
                                    out.println(dropdown.ddmarke(request.getParameter("Marke"),"search"));
                                if(typ.equals("1"))
                                    out.println(dropdown.ddmarkemotorrad(request.getParameter("Marke"),"search"));
                            %>
                            
                        </div>
                        <div>
                            Modell:<br>                         
                            <%
                               if(typ.equals("") || typ.equals("0") ) 
                                    out.println(dropdown.ddmodell(request.getParameter("Marke"),request.getParameter("Modell")));
                               if(typ.equals("1"))
                                   out.println(dropdown.ddmodellmotorrad(request.getParameter("Marke"),request.getParameter("Modell")));
                            %>
                            
                        </div>
                        <div>
                            Erstzulassung ab:<br>
                            <select name="minFirstRegistrationDate" placeholder="Beliebig">
                                <option value="0">Beliebig</option>
                                <option value="2015">2015</option>
                                <option value="2014">2014</option>
                                <option value="2013">2013</option>
                                <option value="2012">2012</option>
                                <option value="2011">2011</option>
                                <option value="2010">2010</option>
                                <option value="2009">2009</option>
                                <option value="2008">2008</option>
                                <option value="2007">2007</option>
                                <option value="2006">2006</option>
                                <option value="2005">2005</option>
                                <option value="2004">2004</option>
                                <option value="2003">2003</option>
                                <option value="2002">2002</option>
                                <option value="2001">2001</option>
                                <option value="2000">2000</option>
                                <option value="1999">1999</option>
                                <option value="1998">1998</option>
                                <option value="1997">1997</option>
                                <option value="1996">1996</option>
                                <option value="1995">1995</option>
                                <option value="1994">1994</option>
                                <option value="1993">1993</option>
                                <option value="1992">1992</option>
                                <option value="1991">1991</option>
                                <option value="1990">1990</option>
                                <option value="1985">1985</option>
                                <option value="1980">1980</option>
                                <option value="1975">1975</option>
                                <option value="1970">1970</option>
                                <option value="1965">1965</option>
                                <option value="1960">1960</option>
                                <option value="1900">1900</option>
                            </select>
                        </div>
                        <div>
                            Kilometer bis:<br>
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
                        <div>
                            Kraftstoffart:<br>
                            <select name="kraftstoffart">
                                <option value="0">Beliebig</option>
                                <option value="Benzin">Benzin</option>
                                <option value="Diesel">Diesel</option>
                                <option value="Elektro">Elektro</option>
                                <option value="Gas">Gas</option>
                                <option value="Hybrid">Hybrid</option>
                            </select>
                        </div>
                        <input type="submit" value="senden" onclick="document.search.search.value=true"><br>
                    </div>
                    
                </form>
            </nav>
                            
             <aside>                 
                <%@include file="aside.jsp" %>              
            </aside>
               
            <section id="content">
                <% 
                    if(request.getParameter("search")!=null && request.getParameter("search").equals("true"))
                    {
                        search s = new search();
                        String n="",mo="",ma="",minez="",maxmil="",ks="";
                        if(request.getParameter("new") != null)
                             n = request.getParameter("new");
                        if(request.getParameter("Modell") != null)
                            mo = request.getParameter("Modell");
                        if(request.getParameter("Marke") != null)
                            ma = request.getParameter("Marke");
                        if(request.getParameter("minFirstRegistrationDate") != null)
                            minez = request.getParameter("minFirstRegistrationDate");
                        if(request.getParameter("maxMileage") != null)
                            maxmil = request.getParameter("maxMileage");
                        if(request.getParameter("kraftstoffart") != null)
                            ks = request.getParameter("kraftstoffart");
                        out.print(s.showSearchResult(n,ma,mo,minez,maxmil,ks));      
                    }
                    else
                    {
                        search s = new search();
                        out.print(s.showRandomOffer());
                    }
                %>
            </section>
            <footer>
                
            </footer>
        </div>  
    </h:body>
</html>
